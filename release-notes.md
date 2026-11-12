## Remote CLI 0.1.7 — macOS Apple Silicon

Install from Terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/jh4578/remote-cli/main/install.sh | bash
```

Or download the `.pkg` below, install it, and run `remote-cli setup`.
The official Claude Code CLI is a separate prerequisite (installed automatically by the script if absent).

Enter your private one-time activation code when prompted, then open a new Terminal and run `claude`.

Renames the public installer, setup command, and package to Remote CLI. Existing device authorization and activation codes remain compatible. Includes the client tool-name compatibility fix. Fresh-user-state end-to-end checks cover chat, Read, approved Edit, image Read, and saved-session continuation against the real AWS backend. Not yet tested on a second physical Mac.

Experimental, unsigned/unnotarized package. Apple Silicon only. The package contains public backend connection settings, not account credentials or activation codes. Activated device keys currently authorize ordinary AWS-user SSH access; use only on trusted personal Macs. This is a download release, not publication of the full gateway source code.
