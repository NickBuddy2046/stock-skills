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

printf '%s\n' 'Configuring TradingView MCP...'
if command -v claude >/dev/null 2>&1; then
  if ! command -v uvx >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
  fi
  if command -v uvx >/dev/null 2>&1; then
    if claude mcp get tradingview >/dev/null 2>&1; then
      printf '%s\n' 'TradingView MCP already exists; keeping the current configuration.'
    else
      claude mcp add --scope user tradingview -- uvx --from tradingview-mcp-server tradingview-mcp
    fi
  else
    printf '%s\n' 'Warning: uvx is unavailable; TradingView MCP was not configured.' >&2
  fi
else
  printf '%s\n' 'Warning: Claude Code CLI is unavailable; TradingView MCP was not configured.' >&2
fi

printf '\n%s\n' 'Stock Skills, the market-data CLI, and the TradingView MCP setup are complete.'
printf '%s\n' 'Authentication is a separate user step; the installer does not wait for it.'
printf '%s\n' 'Recommended for headless or Zo environments:'
printf '%s\n' '  1. Open https://open.longbridge.com/connect in a browser and sign in.'
printf '%s\n' '  2. Copy the one-time authorization code.'
printf '%s\n' '  3. Run: longbridge auth login --auth-code <CODE>'
printf '%s\n' 'If using device flow, run longbridge auth login and open the exact URL it prints before the timeout.'
printf '%s\n' 'Then verify connectivity with:'
printf '%s\n' '  longbridge check'
printf '%s\n' '  claude mcp get tradingview'
