---
title: A geeky/minimal way to do journaling
layout: post
date: 2021-02-09 00:03:09 +0330
categories: productivity
---

I started journaling on a regular basis around 3 years ago. Even before that, I always did my best to stay organized especially about my notes. As you may know, I've been using [Evernote](https://evernote.com){:target="\_blank"} for around 8 years but near a year ago, I decided to [move from Evernote to Apple Notes]({% post_url 2020-05-01-switching-from-evernote %}) because Evernote didn't support many features like right-to-left (I'm not sure if it now supports RTL or not).

Apple Notes is a great tool for do simple note-takings; however, I have recently faced some buggy behavior such as high CPU usage while writing notes and laggy typing experience. In addition, I experienced some difficulties accessing my notes from non-macOS devices using iCloud website. While searching for alternatives, I realized that none of the note-taking apps out there meet my needs. [Notion](https://notion.so){:target="\_blank"} which is, in my opinion, the most comprehensive note-taking solution out there is to complex for me. All I want to do is rich-text writing with support for photo attachment.

## My newest solution

As you may know, I'm a big fan of [Markdown](https://en.wikipedia.org/wiki/Markdown){:target="\_blank"}. In fact, I do most of my writings including this blog in markdown. It's a very simple yet powerful markup language that you will fall in love with its simplicity.

A few weeks ago, I found an app called _[Exporter](http://falcon.star-lord.me/exporter/){:target="\_blank"}_ on the Mac AppStore that let you export notes from Apple Notes app as markdown files! What could be better than this!? I instantly exported all of my notes to markdown and created a private Git repository and pushed all of them there. Git hosting providers such as Github and Gitlab support markdown out of the box. This means your markdown files will be displayed as prettified HTML when you access them via their websites/apps. Also, there are some cool plugins for text-editors like VSCode and [neo]vim that let you preview your markdown files live. Once you've done your daily journal, you can commit that markdown file and push it to a git server so you won't lose it.

You may ask how can I search through my notes? The answer is simple: `grep` and `find`. Here is an example:

```bash
# Search for 'Nika (My daughter's name)' in notes folder.
grep -iRl "Nika" ~/repos/notes
```

I believe this is the simplest way to manage your notes while keeping it in a safe place.
