# JohnCoin (Clarinet/Clarity)

A simple fungible token smart contract for JohnCoin, built with Clarity and organized as a Clarinet project.

- Name: JohnCoin
- Symbol: JOHN
- Decimals: 6
- Fixed supply (base units): 1,000,000 JOHN -> 1,000,000 × 10^6 = 1,000,000,000,000 base units

## Project layout

- Clarinet.toml — Clarinet project configuration
- contracts/johncoin.clar — Clarity smart contract

## Requirements

- Clarinet (https://github.com/hirosystems/clarinet)

## Quick start

1) Validate the project

```bash
clarinet check
```

2) Open a local console

```bash
clarinet console
```

3) In the console, deploy and mint the initial supply (one-time)

Replace `ST...YOUR_ADDRESS` with your Stacks address that should receive the full fixed supply.

```clarity
::contract-call? .johncoin initialize 'ST...YOUR_ADDRESS
```

Notes:
- `initialize` can be called only once; it mints the fixed supply to the specified recipient.
- Until `initialize` is called, the on-chain supply is zero.

4) Transfer tokens

```clarity
::contract-call? .johncoin transfer u100000 'ST...SENDER 'ST...RECIPIENT
```

Amounts are in base units (with 6 decimals). `u100000` equals 0.1 JOHN.

5) Read balances and metadata

```clarity
::contract-call? .johncoin get-balance 'ST...ADDRESS
::contract-call? .johncoin get-total-supply
::contract-call? .johncoin get-name
::contract-call? .johncoin get-symbol
::contract-call? .johncoin get-decimals
```

## Error codes

- u100 — already initialized

## Security notes

This sample keeps things simple. For production, consider:
- Enforcing a known owner/admin address and minting only from that principal
- SIP-010 trait conformance and audits
- Additional controls (pausing, blacklisting, etc.) if needed
