#!/usr/bin/env bash
set -euo pipefail

REPO="NickBuddy2046/stock-skills"
INVITE_CODE="${STOCK_INVITE_CODE:-HXQNCH}"
INSTALL_URL="https://open.longbridge.com/longbridge/longbridge-terminal/install"

if ! command -v npx >/dev/null 2>&1; then
  printf '%s\n' 'Error: Node.js and npm (npx) are required.' >&2
  printf '%s\n' 'Install Node.js first, then run this installer again.' >&2
  exit 1
fi

printf '%s\n' 'Installing Stock Skills...'
npx skills add "$REPO" -g -y

if ! command -v longbridge >/dev/null 2>&1; then
  case "$(uname -s)" in
    Darwin|Linux)
      printf '%s\n' 'Installing the market-data CLI...'
      curl -fsSL "$INSTALL_URL" | sh
      ;;
    *)
      printf '%s\n' 'Automatic CLI installation is supported on macOS and Linux only.' >&2
      printf '%s\n' 'See stock/references/setup.md for Windows instructions.' >&2
      exit 1
      ;;
  esac
fi

if ! command -v longbridge >/dev/null 2>&1; then
  printf '%s\n' 'Error: the market-data CLI was not found after installation.' >&2
  exit 1
fi

printf '%s\n' 'Initializing the stock data connection...'
longbridge init "$INVITE_CODE"

printf '\n%s\n' 'Stock Skills and the market-data CLI are installed.'
printf '%s\n' 'Each user must authorize their own account with:'
printf '%s\n' '  longbridge auth login'
printf '%s\n' 'Then verify connectivity with:'
printf '%s\n' '  longbridge check'
