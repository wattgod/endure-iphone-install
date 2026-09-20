# Endure iPhone install

One-command installer for the **mattidev** Mac. Uses GitHub CLI HTTPS (no SSH key). Starts an **internal Expo / EAS** build — not USB Xcode signing.

Do **not** clone onto the Seagate Time Machine volume. Do **not** use Peaksware Apple or Expo accounts.

```bash
curl -fsSL https://raw.githubusercontent.com/wattgod/endure-iphone-install/main/install.sh | bash
```

Or, if `/Users/mattidev/endure-mobile` already exists (zsh, no `#` comments):

```bash
cd /Users/mattidev/endure-mobile
git checkout main
git restore eas.json
git pull
npm_config_minimum_release_age= npx --yes eas-cli@24.7.0 whoami
ENDURE_SKIP_USB=1 npm run ios:launch
```

Expo account **wattgod**. Apple ID **stormspandies@gmail.com** / team **Endure Labs LLC**. If EAS asks `Do you want to log in to your Apple account?`, type **n**. That prompt is not a credentials form. The real cert UI is `eas credentials --platform ios` so Y/n cannot add credentials. After pull, skip-USB already passes `--non-interactive` plus `EXPO_NO_CAPABILITY_SYNC=1` for internal preview. When EAS asks to register a device, say yes — hardware UDID `00008150-000478983A38401C` (not the CoreDevice UUID `06F79867-B55E-53C7-B05C-4CB996122507`). When the build finishes, open the Expo install page on the iPhone (Safari). Developer Mode on.

USB later: `npm run ios:retry` or Xcode EndureLabs → Team → Endure Labs LLC → ⌘R.
