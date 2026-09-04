# Endure iPhone install

One-command installer for the **mattidev** Mac. Uses GitHub CLI HTTPS (no SSH key). Starts an **internal Expo / EAS** build — not USB Xcode signing.

Do **not** clone onto the Seagate Time Machine volume. Do **not** use Peaksware Apple or Expo accounts.

```bash
curl -fsSL https://raw.githubusercontent.com/wattgod/endure-iphone-install/main/install.sh | bash
```

Or, if `/Users/mattidev/endure-mobile` already exists:

```bash
cd /Users/mattidev/endure-mobile
git checkout main
git pull
npm run ios:launch
```

Expo account **wattgod**. Apple ID **stormspandies@gmail.com** / team **Endure Labs LLC**. When EAS asks to register a device, say yes — UDID `06F79867-B55E-53C7-B05C-4CB996122507`. When the build finishes, open the Expo install page on the iPhone (Safari). Developer Mode on.

USB later: `npm run ios:retry` or Xcode EndureLabs → Team → Endure Labs LLC → ⌘R.
