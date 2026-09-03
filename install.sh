#!/usr/bin/env bash
# Install Endure Labs on a connected iPhone. HTTPS via GitHub CLI — no SSH key.
set -euo pipefail

DEST="${HOME}/endure-mobile"

die() { echo "ERROR: $*" >&2; exit 1; }
[[ "$(uname)" == "Darwin" ]] || die "Run this on the Mac mini."
command -v gh >/dev/null || die "Install GitHub CLI: brew install gh"

if ! gh auth status -h github.com >/dev/null 2>&1; then
  echo "A browser will open. Log in as wattgod."
  gh auth login -h github.com -p https -w
fi

if [[ -d "$DEST/.git" ]]; then
  git -C "$DEST" pull --ff-only
else
  gh repo clone wattgod/endure-mobile "$DEST"
fi

cd "$DEST"
[[ -f package.json ]] || die "Clone incomplete"
grep -q '"ios:install"' package.json || die "$DEST is not endure-mobile"

[[ -d node_modules ]] || npm ci
npm run ios:install
