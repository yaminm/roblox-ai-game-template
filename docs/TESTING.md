# Verification and runtime acceptance

## Repository gate

Install Git, Python 3, Bash, and Rokit 1.2.0. Follow the
[official Rokit installation guide](https://github.com/rojo-rbx/rokit#installation),
then run these commands from any directory:

```sh
./scripts/bootstrap.sh
./scripts/verify.sh
```

Bootstrap uses only `rokit.toml` and its exact pins, trusts those tool repositories,
and provisions checksum-pinned Roblox analyzer definitions. After bootstrap,
verification is offline. Selene uses `tooling/roblox.yml`, the checked-in snapshot
from Selene 0.31.0. Tool/type/snapshot upgrades require explicit review.

When GitHub CLI credentials exist, bootstrap captures them privately into Rokit's
owner-only auth file. Tokens are never printed or passed as command arguments.
On a multi-account workstation use `git config --local harness.githubUser LOGIN`
or `ROKIT_GITHUB_USER=LOGIN`; an unavailable selected account never falls back to
another CLI user. If downloads hit a rate limit, authenticate the intended account
with `gh auth login --hostname github.com` and rerun bootstrap. CI supplies its
read-only token via GitHub CLI to the same bootstrap.

The gate checks staged/unstaged whitespace, committed whitespace, formatting,
linting, Rojo sourcemap, Roblox-aware luau-lsp analysis of `src` and `tests`, initialization safety tests with Python, every
`tests/unit/**/*.spec.luau` file with Lune, and builds `build/game.rbxlx`.
Lune executes unit tests only. Add engine-independent assertions alongside
behavior changes; use Studio for engine-dependent behavior. At least one unit
spec is required. Missing tools/definitions tell you to rerun bootstrap.

`VERIFY_BASE_SHA=<commit> ./scripts/verify.sh` checks committed changes from that
base to HEAD. Without a base it checks HEAD's parent; initial commits use an
empty tree. An explicit missing base fails. CI fetches full history and provides
the PR base SHA (its checkout is the test merge) or pre-push SHA on `main`.
The workflow invokes bootstrap and the same gate, with no Studio tests.

## Template smoke test + game acceptance

After [MCP setup](MCP_SETUP.md), load the current Rojo build or sync. Use
`list_roblox_studios`, explicitly select the intended file/instance ID, and check
`get_studio_state`. On Edit, inspect:

- `ReplicatedStorage.Shared.GameConfig` (ModuleScript);
- `ServerScriptService.Server.main` (Script);
- `StarterPlayer.StarterPlayerScripts.Client.main` (LocalScript);
- expected project world instances.

Read each mounted Script.Source through MCP and compare with disk. Reading is
allowed; fix mismatches through Rojo/build, never through a Studio source edit.
Start a real playtest. On Server assert `ReplicatedStorage:GetAttribute("ServerReady")`
is true; on Client assert `Players.LocalPlayer:GetAttribute("ClientReady")` is true.
Confirm both bootstrap messages, a live character, and the expected DataModel.

Then exercise GAME.md scenarios using actual input/touches and game handlers.
Inspect authoritative server state and client presentation, invalid-input paths,
Output on both sides, and visuals for UI/world changes. Do not grant rewards or
write gameplay attributes to manufacture a pass. Bounded temporary probes are
allowed; remove them after use. The MCP sandbox may prohibit `require` of game
modules; read state or evaluate repository-owned pure probe code instead of
changing capabilities. Record actions, expected/observed results, source revision,
and limits in the task PR; retain screenshots when they substantiate visual work.

Read `get_console_output` and server/client LogService histories for new errors
and warnings. Stop play and confirm Studio returns to Edit. Both the generic
smoke and game-specific acceptance must pass for runtime changes. Build-only
success cannot establish runtime correctness. If Studio tools are unavailable,
report the exact pending scenarios; keep runtime-dependent work incomplete.
