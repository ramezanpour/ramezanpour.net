#!/usr/bin/env ruby
# Adds a book to _data/books.yml, pulling title, author and cover from Goodreads.
#
#   ruby _scripts/add_book.rb [goodreads-url-or-id]
#
# Covers are saved to assets/images/books/<book-id>.jpg and scaled to 475px tall
# to match the rest of the list.

require 'json'
require 'open3'
require 'yaml'
require 'date'
require 'cgi'

ROOT     = File.expand_path('..', __dir__)
DATA     = File.join(ROOT, '_data/books.yml')
COVERS   = File.join(ROOT, 'assets/images/books')
AGENT    = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 ' \
           '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
HEADERS  = ['-H', 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            '-H', 'Accept-Language: en-US,en;q=0.9']
COVER_PX = 475

def abort!(msg)
  warn "\e[31m✗\e[0m #{msg}"
  exit 1
end

def ask(prompt, default = nil)
  print default && !default.empty? ? "#{prompt} [#{default}]: " : "#{prompt}: "
  answer = ($stdin.gets || '').strip
  answer.empty? ? default.to_s : answer
end

# Goodreads answers Ruby's HTTP client with an empty 202, so shell out to curl.
# It also sits behind a WAF that rate-limits scripted requests, hence the retries;
# a nil return means "give up quietly and ask the user instead".
def get(url, tries: 3)
  tries.times do |attempt|
    sleep(2 * attempt) if attempt.positive?
    body, status = Open3.capture2('curl', '-sSL', '--compressed', '--max-time', '30',
                                  '-A', AGENT, *HEADERS, '-w', '\n%{http_code}', url)
    next unless status.success?

    body, code = body.rpartition("\n").values_at(0, 2)
    return body if code == '200' && !body.strip.empty?
    return nil if body.include?('awsWafCookieDomainList')   # bot challenge, retrying won't help
  end
  nil
end

# --- Identify the book ------------------------------------------------------

input = ARGV[0] || ask('Goodreads URL or ID')
abort!('No book given.') if input.empty?

id = input[%r{/book/show/(\d+)}, 1] || input[/\A(\d+)\z/, 1]
abort!("Could not find a book ID in #{input.inspect}.") unless id

link = "https://www.goodreads.com/book/show/#{id}"

raw    = File.read(DATA)
header = raw[/\A(?:#[^\n]*\n|\n)*/]        # keep the comment block at the top
data   = YAML.safe_load(raw) || {}
data['reading'] ||= []
data['read']    ||= []

if (dupe = (data['reading'] + data['read']).find { |b| b['link'] == link })
  abort!("#{dupe['title'].inspect} is already in _data/books.yml.")
end

puts "→ fetching goodreads.com/book/show/#{id}"
page = get("https://www.goodreads.com/book/show/#{id}")

unless page
  warn "  Goodreads blocked the request (bot check). Falling back to manual entry —"
  warn "  open https://www.goodreads.com/book/show/#{id} and copy the details across."
  page = ''
end

book = page.scan(%r{<script type="application/ld\+json">(.*?)</script>}m)
           .filter_map { |m| JSON.parse(m[0]) rescue nil }
           .find { |d| d['@type'] == 'Book' }

title  = book && book['name']
title ||= CGI.unescapeHTML(page[/<meta property="og:title" content="([^"]*)"/, 1].to_s)
# the URL slug is a decent last resort: /book/show/43306206-the-courage-to-be-disliked
title = input[%r{/book/show/\d+-([a-z0-9-]+)}, 1].to_s.tr('-', ' ').split.map(&:capitalize).join(' ') if title.strip.empty?
authors = book ? Array(book['author']).map { |a| a['name'] }.compact : []

title = ask('Title', title)
abort!('A title is required.') if title.strip.empty?
author = ask('Author', authors.first)

# --- Shelf and reading details ----------------------------------------------

shelf = ''
until %w[reading read].include?(shelf)
  shelf = ask('Shelf (reading/read)', 'reading').downcase
end

entry = { 'title' => title, 'author' => author }
entry.delete('author') if author.empty?

if shelf == 'read'
  rating = ask('Rating 1-5 (blank for unrated)', '')
  entry['rating'] = rating.to_i if (1..5).cover?(rating.to_i)
  date = nil
  until date
    answer = ask('Date read (YYYY-MM-DD)', Date.today.to_s)
    date = (Date.parse(answer) rescue nil)
    warn '  not a valid date' unless date
  end
  entry['read'] = date.to_s
end

# --- Cover ------------------------------------------------------------------

cover_url = page[/<meta property="og:image" content="([^"]+)"/, 1]
cover_url = nil if cover_url.to_s.include?('nophoto')
cover_url = ask('Cover image URL (blank to skip)', '') if cover_url.nil?
cover_url = nil if cover_url.to_s.strip.empty?

if cover_url
  path = File.join(COVERS, "#{id}.jpg")
  puts '→ downloading cover'
  ok = system('curl', '-sSL', '--max-time', '30', '-A', AGENT,
              CGI.unescapeHTML(cover_url), '-o', path, out: File::NULL, err: File::NULL)
  if !ok || !File.exist?(path) || File.size(path) < 1000
    File.delete(path) if File.exist?(path)
    warn '  cover download failed, skipping'
  else
    system('sips', '-Z', COVER_PX.to_s, path, out: File::NULL, err: File::NULL)
    entry['cover'] = "/assets/images/books/#{id}.jpg"
  end
else
  warn '  no cover on Goodreads, skipping'
end

entry['link'] = link

# --- Write ------------------------------------------------------------------

data[shelf].unshift(entry)
data['read'].sort_by! { |b| b['read'].to_s }.reverse! if shelf == 'read'

File.write(DATA, header + YAML.dump('reading' => data['reading'], 'read' => data['read']).sub(/\A---\n/, ''))

shelf_label = shelf == 'read' ? 'read' : 'currently reading'
puts "\e[32m✓\e[0m added #{title.inspect}#{author.empty? ? '' : " by #{author}"} to #{shelf_label}"
