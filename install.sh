#!/bin/bash
set -euo pipefail

VERSION=0.1.7
PACKAGE="Remote-CLI-${VERSION}-macOS-arm64.pkg"
SHA256=7eca79cc4698212ea9d69f082531b2b3288c3fd05f143de2a4d84e0bda6b1111
BASE="https://github.com/jh4578/remote-cli/releases/download/v${VERSION}"

if [[ "$(uname -s)" != Darwin || "$(uname -m)" != arm64 ]]; then
  echo 'This installer requires an Apple Silicon Mac.' >&2
  exit 1
fi
if [[ "${1:-}" != '' && "${1:-}" != --download-only ]]; then
  echo 'Usage: bash install.sh [--download-only]' >&2
  exit 1
fi
if [[ ${EUID} == 0 ]]; then
  echo 'Run this as your normal Mac user, not with sudo.' >&2
  exit 1
fi
if [[ "${1:-}" != --download-only && ! -t 1 ]]; then
  echo 'Run this installer in an interactive Terminal.' >&2
  exit 1
fi

WORK=$(mktemp -d "${TMPDIR:-/tmp}/remote-cli-install.XXXXXXXX")
trap 'rm -f "$WORK/$PACKAGE" "$WORK/claude-install.sh"; rmdir "$WORK" 2>/dev/null || true' EXIT
echo "Downloading Remote CLI ${VERSION}…"
curl --fail --show-error --silent --location --proto '=https' --proto-redir '=https' \
  "$BASE/$PACKAGE" -o "$WORK/$PACKAGE"
ACTUAL=$(shasum -a 256 "$WORK/$PACKAGE" | awk '{print $1}')
if [[ "$ACTUAL" != "$SHA256" ]]; then
  echo 'Checksum mismatch. Nothing was installed.' >&2
  exit 1
fi
echo 'Package SHA-256 verified.'

if [[ "${1:-}" == --download-only ]]; then
  # Preserve the verified download; do not touch an existing file.
  if [[ -e "$PWD/$PACKAGE" ]]; then
    echo "Already exists: $PWD/$PACKAGE" >&2
    exit 1
  fi
  (set -o noclobber; cp -n "$WORK/$PACKAGE" "$PWD/$PACKAGE")
  echo "Saved: $PWD/$PACKAGE"
  exit 0
fi

if ! command -v claude >/dev/null 2>&1 && [[ ! -x "$HOME/.local/bin/claude" ]]; then
  echo 'Installing the official Claude Code CLI (2.1.118)…'
  curl --fail --show-error --silent --location --proto '=https' --proto-redir '=https' \
    https://claude.ai/install.sh -o "$WORK/claude-install.sh"
  bash "$WORK/claude-install.sh" 2.1.118 </dev/tty
fi
export PATH="$HOME/.local/bin:$PATH"
echo 'Installing Remote CLI. macOS will ask for administrator authorization.'
echo 'This development package is not Apple Developer ID signed or notarized.'
# The terminal is intentionally opened as the invoking user, not as root.
# shellcheck disable=SC2024
sudo /usr/sbin/installer -pkg "$WORK/$PACKAGE" -target / </dev/tty
echo 'Set up this Mac. Paste your private activation code when requested.'
/usr/local/bin/remote-cli setup </dev/tty
echo 'Open a NEW Terminal, enter your project folder, then run: claude'
