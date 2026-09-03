# Endure iPhone install

Public helper for the **mattidev** Mac. Clones private `wattgod/endure-mobile` with GitHub CLI (HTTPS), then `npm run ios:install`.

`gh` is already on that machine. Paste:

```bash
set -euo pipefail
cd /Users/mattidev
gh auth status -h github.com >/dev/null 2>&1 || gh auth login -h github.com -p https -w
gh repo clone wattgod/endure-mobile /Users/mattidev/endure-mobile
cd /Users/mattidev/endure-mobile
test -f package.json
npm ci
npm run ios:install
```

Do **not** use `git clone git@github.com:...` until an SSH key exists.
