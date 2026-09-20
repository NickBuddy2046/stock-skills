# Stock Skills

A rebranded bundle of stock and market-analysis skills under the `stock` namespace.

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

The current local setup keeps its existing backend command names and authentication flow unchanged. Rebranding the skill namespace does not create a new market-data provider or transfer account access to other users.

## Sharing

Share the repository URL or the install command. Each person must configure their own market-data backend and account permissions. Never share an OAuth token, API key, or local token cache.
