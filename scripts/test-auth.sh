#!/usr/bin/env bash
# Verifies whether Longbridge authorization completed successfully.
# Run this after the user reports they finished the browser step from
# start-auth.sh. Prints machine-readable JSON; never prints secrets.
set -uo pipefail

if ! command -v longbridge >/dev/null 2>&1; then
  echo '{"ok":false,"reason":"longbridge CLI not installed"}'
  exit 1
fi

STATUS_JSON="$(longbridge auth status --format json 2>/dev/null)"
if [ -z "$STATUS_JSON" ] || ! echo "$STATUS_JSON" | grep -q '"account"'; then
  echo '{"ok":false,"reason":"not authorized yet"}'
  exit 1
fi

QUOTE_JSON="$(longbridge quote AAPL.US --format json 2>/dev/null)"
if [ -z "$QUOTE_JSON" ]; then
  echo '{"ok":false,"reason":"authorized, but test quote failed"}'
  exit 1
fi

echo '{"ok":true,"reason":"authorized and quote test succeeded"}'
