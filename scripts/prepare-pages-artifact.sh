#!/bin/sh

set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
DIST_DIR="$ROOT_DIR/dist"

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

for file in index.html styles.css script.js; do
  cp "$ROOT_DIR/$file" "$DIST_DIR/$file"
done

touch "$DIST_DIR/.nojekyll"

DOMAIN_VALUE=${PRAETOR_PAGES_CNAME:-praetorhomesystems.com}

printf '%s\n' "$DOMAIN_VALUE" > "$DIST_DIR/CNAME"
