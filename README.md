# Stock Skills

A rebranded bundle of stock and market-analysis skills under the `stock` namespace.

## Full setup

To install the skills, install the market-data CLI, initialize referral code `HXQNCH`, and configure TradingView MCP without a Marketaux token in one step:

```bash
curl -fsSL https://raw.githubusercontent.com/NickBuddy2046/stock-skills/main/install.sh | bash
```

The script installs the official CLI on macOS/Linux, runs `longbridge init HXQNCH`, and configures the token-free TradingView MCP. It does not start an OAuth flow or wait for a browser, so the install command will not hang. It also downloads two helper scripts to `~/.stock-skills/scripts/`.

### Recommended for Zo Computer / AI agents: hand off a login link

1. After `install.sh` finishes, run `~/.stock-skills/scripts/start-auth.sh`. It starts the device-authorization login in the background (non-blocking) and prints a one-time URL.
2. Give that URL to the user and ask them to open it in **any browser on their own device** and approve the sign-in. Do not open it yourself or ask for the code back in chat.
3. When the user reports they're done, run `~/.stock-skills/scripts/test-auth.sh`. It checks `longbridge auth status` and runs a live `AAPL.US` quote, printing `{"ok":true,...}` or `{"ok":false,"reason":"..."}`.
4. If it reports `not authorized yet`, the device-flow link likely expired before the user opened it — re-run `start-auth.sh` for a fresh URL and try again.

Neither script prints or stores passwords, OAuth tokens, or API keys.

### Manual alternative

1. Open <https://open.longbridge.com/connect> in any browser and sign in.
2. Copy the one-time authorization code.
3. Run `longbridge auth login --auth-code <CODE>` in the Terminal.
4. Verify with `longbridge check` and `claude mcp get tradingview`.

## Install

```bash
npx skills add NickBuddy2046/stock-skills -g -y
```

The base skill is `stock`. Specialist skills use the `stock-*` names.

### Note for Zo Computer users

The `-g` (global) install above works for Claude Code, Codex, and Hermes Agent, but **not** for `promptscript` — the agent identifier Zo Computer's own skill loader registers under `npx skills`. That agent only supports project-scoped installs, so a global-only install leaves Zo Computer's own chat unable to see the skills even though the command reports success. `install.sh` now runs a second, project-scoped pass rooted at `/home/workspace` specifically for `promptscript` to cover this. If installing manually (not via `install.sh`), also run:

```bash
cd /home/workspace && npx skills add NickBuddy2046/stock-skills -y --skill '*' --agent promptscript
```

## Included skills

- `stock`
- `stock-market-data`
- `stock-portfolio`
- `stock-fundamentals`
- `stock-technical`
- `stock-research`
- `stock-quant`
- `stock-earnings`
- `stock-content`
- `stock-intel`
- `stock-derivatives`
- `stock-watchlist`
- `stock-value-investing`

## Backend

The skills are instruction and workflow files. Market data, account access, authentication, and trading permissions are supplied by the user's configured brokerage CLI or MCP backend; this repository does not contain credentials.

The current local setup keeps its existing backend command names and authentication flow unchanged. Rebranding the skill namespace does not create a new market-data provider or transfer account access to other users. The full setup script installs the same backend used by this bundle, initializes referral code `HXQNCH`, and configures TradingView MCP without Marketaux. It cannot complete personal OAuth authorization on behalf of another user.

## Sharing

Share the repository URL or the install command. Each person must configure their own market-data backend and account permissions. Never share an OAuth token, API key, or local token cache.
