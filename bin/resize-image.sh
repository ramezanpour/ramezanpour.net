#!/usr/bin/env bash
#
# Resize image(s) to a max width and save them into assets/images/.
# Uses macOS's built-in `sips` — no external dependencies.
#
# Usage:
#   bin/resize-image.sh ~/Downloads/huge-photo.jpg [more.jpg ...]
#
# The original file is left untouched; a resized copy is written to
# assets/images/. Aspect ratio is preserved, and images already narrower
# than the target width are copied without upscaling.
#
# Override the target width (default 700) with the WIDTH env var:
#   WIDTH=1000 bin/resize-image.sh photo.jpg

set -euo pipefail

WIDTH="${WIDTH:-700}"

# assets/images relative to this script's location, so it works from any cwd.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest_dir="$script_dir/../assets/images"

if [ "$#" -eq 0 ]; then
  echo "Usage: $(basename "$0") <image> [image ...]" >&2
  echo "Resizes to ${WIDTH}px wide and saves into assets/images/." >&2
  exit 1
fi

mkdir -p "$dest_dir"

web_paths=""  # web paths of processed files, for the clipboard

for src in "$@"; do
  # Expand a leading ~ / ~/ (stays literal when the path was quoted).
  case "$src" in
    "~") src="$HOME" ;;
    "~/"*) src="$HOME/${src#\~/}" ;;
  esac

  if [ ! -f "$src" ]; then
    echo "Skipping (not found): $src" >&2
    continue
  fi

  # Normalize the output name: lowercase, spaces -> underscores.
  base="$(basename "$src")"
  name="$(echo "$base" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')"

  # HEIC/HEIF isn't web-friendly: convert to JPG and rename the extension.
  ext="$(echo "${name##*.}" | tr '[:upper:]' '[:lower:]')"
  to_jpg=false
  if [ "$ext" = "heic" ] || [ "$ext" = "heif" ]; then
    name="${name%.*}.jpg"
    to_jpg=true
  fi

  out="$dest_dir/$name"

  if [ -e "$out" ]; then
    echo "Skipping (already exists): assets/images/$name" >&2
    continue
  fi

  cur_width="$(sips -g pixelWidth "$src" | awk '/pixelWidth/ {print $2}')"

  if [ -n "$cur_width" ] && [ "$cur_width" -le "$WIDTH" ]; then
    if [ "$to_jpg" = true ]; then
      sips -s format jpeg "$src" --out "$out" >/dev/null
      echo "Converted to JPG (already ${cur_width}px wide): assets/images/$name"
    else
      cp "$src" "$out"
      echo "Copied (already ${cur_width}px wide): assets/images/$name"
    fi
  else
    if [ "$to_jpg" = true ]; then
      sips -s format jpeg --resampleWidth "$WIDTH" "$src" --out "$out" >/dev/null
      echo "Converted to JPG & resized ${cur_width:-?}px -> ${WIDTH}px: assets/images/$name"
    else
      sips --resampleWidth "$WIDTH" "$src" --out "$out" >/dev/null
      echo "Resized ${cur_width:-?}px -> ${WIDTH}px: assets/images/$name"
    fi
  fi

  web_paths="${web_paths}/assets/images/$name"$'\n'
done

# Copy the web path(s) to the clipboard for pasting into a post's front matter.
if [ -n "$web_paths" ] && command -v pbcopy >/dev/null 2>&1; then
  printf '%s' "$web_paths" | pbcopy
  echo "Copied path to clipboard."
fi
