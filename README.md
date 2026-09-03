# Endure iPhone install

gh is already installed on the mattidev Mac. Next:

```bash
set -euo pipefail
cd /Users/mattidev
gh auth status -h github.com >/dev/null 2>&1 || gh auth login -h github.com -p https -w --skip-ssh-key
gh repo clone wattgod/endure-mobile /Users/mattidev/endure-mobile
cd /Users/mattidev/endure-mobile
test -f package.json
npm ci
npm run ios:install
```

Do not use `git clone git@github.com:...`.
