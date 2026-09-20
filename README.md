# Stock Skills

A rebranded bundle of stock and market-analysis skills under the `stock` namespace.

## Full setup

To install the skills, install the market-data CLI, and initialize the default referral configuration in one step:

```bash
curl -fsSL https://raw.githubusercontent.com/NickBuddy2046/stock-skills/main/install.sh | bash
```

The script installs the official CLI on macOS/Linux and runs `longbridge init` with the bundled referral code. Each user must still authorize their own account:

```bash
longbridge auth login
longbridge check
```

The script does not receive or store passwords, OAuth tokens, or API keys.

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

The current local setup keeps its existing backend command names and authentication flow unchanged. Rebranding the skill namespace does not create a new market-data provider or transfer account access to other users. The full setup script installs the same backend used by this bundle; it cannot complete personal OAuth authorization on behalf of another user.

## Sharing

Share the repository URL or the install command. Each person must configure their own market-data backend and account permissions. Never share an OAuth token, API key, or local token cache.
