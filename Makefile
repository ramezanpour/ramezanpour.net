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

photo:
	@read -p "Caption/title: " title; \
	if [ -z "$$title" ]; then echo "Title cannot be empty."; exit 1; fi; \
	date=$$(date +%Y-%m-%d); \
	slug=$$(echo "$$title" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$$//'); \
	file="_posts/$$date-$$slug.md"; \
	if [ -e "$$file" ]; then echo "File already exists: $$file"; exit 1; fi; \
	printf -- '---\ntitle: %s\nlayout: photo\ndate: %s\ncategories: photos\nlocation: ""\ndescription: ""\nimage: /assets/images/CHANGE-ME.jpg\nimages:\n  - /assets/images/CHANGE-ME.jpg\n---\n\n' "$$title" "$$date" > "$$file"; \
	echo "Created $$file"; \
	nvim "$$file"

img:
	@if [ -z "$(FILE)" ]; then \
		echo "Usage: make img FILE=<image> [WIDTH=700]"; \
		echo "For multiple files or globs, call the script directly:"; \
		echo "  bin/resize-image.sh ~/Downloads/*.jpg"; \
		exit 1; \
	fi; \
	w="$(WIDTH)"; WIDTH="$${w:-700}" bin/resize-image.sh "$(FILE)"
