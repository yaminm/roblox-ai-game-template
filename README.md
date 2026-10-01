# RobloxAIGameTemplate

AI-first Roblox development baseline: Git + Rojo + pinned Rokit tools + Roblox Studio MCP.

## One-time workstation setup

1. Install Roblox Studio, Git, and **Rokit**.
2. From this repository, run `rokit install`.
3. Run `lune run scripts/bootstrap.luau`.
4. Open Roblox Studio and enable **Studio as MCP server** under Assistant -> `...` -> Manage MCP Servers.
5. Quick-connect your coding harness (Codex CLI / Claude Code / Cursor when available).

## Daily loop

Terminal A:

```sh
rojo serve
```

Open `build/game.rbxlx` (or a project place), then connect the Rojo Studio plugin. Let the agent edit
filesystem-owned code, use MCP for runtime inspection/playtesting, and keep Studio-only changes within
the ownership policy.

Before committing:

```sh
lune run scripts/verify.luau
```

Runtime/gameplay/UI changes must additionally be playtested through Studio MCP.

## Important docs

- `AGENTS.md` - agent contract and guardrails
- `GAME.md` - product/game contract
- `docs/OWNERSHIP.md` - filesystem vs Studio ownership
- `docs/TESTING.md` - verification gates
- `docs/SECURITY.md` - server-authority baseline
- `docs/MCP_SETUP.md` - MCP setup

## MCP smoke test

Once Rojo and MCP are connected, ask your agent:

> Inspect the current Roblox Studio DataModel through MCP. Confirm `ReplicatedStorage.Shared`,
> `ServerScriptService.Server`, and `StarterPlayerScripts.Client` exist. Start a playtest, verify the
> server and client harness-ready messages appear without new errors, then stop the playtest. Do not
> edit any filesystem-owned Script source through MCP.

The repository intentionally has **zero third-party runtime dependencies** at baseline. Add packages
only when a real game need justifies them; then add the corresponding Rojo package mounts, run `wally install`,
and commit `wally.lock`.
