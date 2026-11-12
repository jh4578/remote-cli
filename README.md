# Remote CLI downloads

Connect the official local Claude Code CLI to your existing AWS backend.

## Install — Apple Silicon Mac

Open Terminal and paste:

```sh
curl -fsSL https://raw.githubusercontent.com/jh4578/remote-cli/main/install.sh | bash
```

Allow the macOS installer, then paste your private activation code when asked.
Open a **new Terminal**, enter your project folder, and run:

```sh
claude
```

No local Claude account login is needed. A valid activation code and access to
the existing backend are required. Public download does not grant backend access.

## Direct download

[Download Remote CLI 0.1.7](https://github.com/jh4578/remote-cli/releases/download/v0.1.7/Remote-CLI-0.1.7-macOS-arm64.pkg)

After installing the official Claude Code CLI and this package, run `remote-cli setup`.

To inspect the script before running it:

```sh
curl -fsSLo install.sh https://raw.githubusercontent.com/jh4578/remote-cli/main/install.sh
less install.sh
bash install.sh
```

## Scope and security

- macOS / Apple Silicon only. This is an experimental API adapter, not an official Anthropic product.
- The official Claude CLI is downloaded separately and is not redistributed in this package.
- Package integrity is checked against a pinned SHA-256. The package is not Developer ID signed or notarized; do not disable system security protections.
- No activation codes, SSH private keys, or Claude login credentials are published here.
- An activated device currently receives SSH access to the configured AWS user, not a narrowly scoped model-only credential. Activate only your own trusted Macs. Activation-code expiry does not revoke an already activated device.
- Tests passed using fresh local user state and the real backend on one Mac; a second physical Mac has not yet been verified.
- This repository distributes the installer and package; it is not a release of the complete gateway source under an open-source license.

For private personal use with your own account and devices. Follow the upstream Claude Code terms and do not share backend/account access with other users.
