run:
	bundle exec jekyll serve --livereload --drafts

new:
	@read -p "Post title: " title; \
	if [ -z "$$title" ]; then echo "Title cannot be empty."; exit 1; fi; \
	date=$$(date +%Y-%m-%d); \
	slug=$$(echo "$$title" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$$//'); \
	file="_posts/$$date-$$slug.md"; \
	if [ -e "$$file" ]; then echo "File already exists: $$file"; exit 1; fi; \
	printf -- '---\ntitle: %s\nlayout: post\ndate: %s\ncategories: thoughts\ndescription: ""\nimage:\n---\n\n' "$$title" "$$date" > "$$file"; \
	echo "Created $$file"; \
	nvim "$$file"

