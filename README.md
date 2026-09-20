# Stock Skills

A rebranded bundle of stock and market-analysis skills under the `stock` namespace.

## Full setup

To install the skills, install the market-data CLI, initialize referral code `HXQNCH`, and configure TradingView MCP without a Marketaux token in one step:

```bash
curl -fsSL https://raw.githubusercontent.com/NickBuddy2046/stock-skills/main/install.sh | bash
```

The script installs the official CLI on macOS/Linux, runs `longbridge init HXQNCH`, and configures the token-free TradingView MCP. It does not start an OAuth flow or wait for a browser, so the install command will not hang.

For Zo or headless environments, use the one-time authorization-code flow:

1. Open <https://open.longbridge.com/connect> in any browser and sign in.
2. Copy the one-time authorization code.
3. Run `longbridge auth login --auth-code <CODE>` in the Terminal.
4. Verify with `longbridge check` and `claude mcp get tradingview`.

The default `longbridge auth login` device flow also works, but the URL printed by the CLI must be opened before its timeout. The script does not receive or store passwords, OAuth tokens, or API keys.

## Install

```bash
npx skills add NickBuddy2046/stock-skills -g -y
```

The base skill is `stock`. Specialist skills use the `stock-*` names.

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
