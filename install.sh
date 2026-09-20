#!/usr/bin/env bash
# Install Endure Labs on the iPhone via an internal Expo (EAS) link.
# HTTPS via GitHub CLI — no SSH key. Clone to $HOME, never Seagate.
# Expo: wattgod. Apple: stormspandies@gmail.com / Endure Labs LLC. Never Peaksware.
# Hardware UDID for ad hoc: 00008150-000478983A38401C
# Do not register CoreDevice UUID 06F79867-B55E-53C7-B05C-4CB996122507.
set -euo pipefail

DEST="${HOME}/endure-mobile"
UDID="00008150-000478983A38401C"

die() { echo "ERROR: $*" >&2; exit 1; }
[[ "$(uname)" == "Darwin" ]] || die "Run this on the mattidev Mac."
command -v gh >/dev/null || die "Install GitHub CLI: brew install gh"
command -v git >/dev/null || die "Git not found. xcode-select --install"
command -v node >/dev/null || die "Node.js not found. Install LTS from https://nodejs.org"

if ! gh auth status -h github.com >/dev/null 2>&1; then
  echo "A browser will open. Log in as wattgod."
  gh auth login -h github.com -p https -w --skip-ssh-key
fi

if [[ -d "$DEST/.git" ]]; then
  echo "==> Updating $DEST (main)"
  git -C "$DEST" fetch origin main
  git -C "$DEST" checkout main
  # Dirty local eas.json blocked git pull. Restore, do not commit PNG dirt.
  git -C "$DEST" restore eas.json 2>/dev/null || true
  git -C "$DEST" pull --ff-only origin main
else
  echo "==> Cloning wattgod/endure-mobile over HTTPS"
  gh repo clone wattgod/endure-mobile "$DEST"
fi

cd "$DEST" || die "Could not open $DEST"
[[ -f package.json ]] || die "Clone incomplete"
grep -qE '"ios:(install|launch)"' package.json || die "$DEST is not endure-mobile"

[[ -d node_modules ]] || npm ci

# Matt's npmrc minimum-release-age refused eas-cli@24.7.0.
export npm_config_minimum_release_age=
export ENDURE_SKIP_USB=1

echo "==> Internal Expo install (EAS first). Expo: wattgod. Apple: stormspandies@gmail.com / Endure Labs LLC."
echo "    If EAS asks Do you want to log in to your Apple account, type n."
echo "    That prompt is not a credentials form. Real cert UI is eas credentials --platform ios so Y/n cannot add credentials."
echo "    If EAS asks to register a device, yes — hardware UDID $UDID"
if grep -q '"ios:launch"' package.json; then
  npm run ios:launch
else
  npm run ios:install
fi
