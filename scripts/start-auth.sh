#!/usr/bin/env bash
# Starts the Longbridge device-authorization login in the background and
# prints the URL the user must open in their own browser to approve it.
# Designed for an AI agent (e.g. Zo Computer) to call non-interactively:
# it never blocks waiting for the user to finish authorizing.
set -uo pipefail

if ! command -v longbridge >/dev/null 2>&1; then
  echo "Error: the 'longbridge' CLI is not installed. Run install.sh first." >&2
  exit 1
fi

LOG_FILE="${STOCK_AUTH_LOG:-$HOME/.stock-skills-auth.log}"
: > "$LOG_FILE"

nohup longbridge auth login >>"$LOG_FILE" 2>&1 &
echo $! >"${LOG_FILE}.pid"

URL=""
for _ in $(seq 1 20); do
  URL="$(grep -oE 'https://open\.longbridge\.[a-z.]+/oauth2/device/authorize/confirm[^[:space:]]*' "$LOG_FILE" | tail -1)"
  [ -n "$URL" ] && break
  sleep 0.5
done

if [ -z "$URL" ]; then
  echo "Error: did not receive an authorization URL within 10s. Log:" >&2
  cat "$LOG_FILE" >&2
  exit 1
fi

echo "$URL"
