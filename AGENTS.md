# Agent contract

Before editing, read [GAME.md](GAME.md), [architecture](docs/ARCHITECTURE.md),
[ownership](docs/OWNERSHIP.md), [testing](docs/TESTING.md), and
[security](docs/SECURITY.md). Inspect Git status, the current branch, and recent
history; preserve unrelated work. Resolve acceptance criteria from GAME.md and
the user's task before implementing a milestone.

Make the smallest coherent change in strict Luau. Git is authoritative for
source and configuration: edit Rojo-owned source on disk, never permanently
through Studio MCP. Keep trusted state server-owned; validate client intent.
Add/update tests with behavior changes. Keep the baseline dependency-free;
avoid unrelated refactors and require approval for dependencies/frameworks.

Before completion:
1. Run `./scripts/verify.sh` and resolve failures.
2. Inspect the full diff and self-review correctness, scope, security, tests,
   source ownership, and accidental changes.
3. For gameplay, UI, physics, replication, hierarchy, remotes, character, or
   other runtime changes, perform the actual Studio MCP playtest in
   [TESTING.md](docs/TESTING.md). A build is not runtime evidence. If Studio is
   unavailable, report runtime validation pending and do not claim completion.
4. Follow [CODEX_WORKFLOW.md](docs/CODEX_WORKFLOW.md): commit coherent verified
   work on the intended task branch, push, create/update its PR, and inspect CI.
   Report commands/results, runtime observations, commit/PR, and remaining limits.

Merging, production publishing/deployment, modifying secrets, production data
mutations, public/paid asset uploads, and destructive Git operations require
explicit human approval. Never merge by default. Repository bootstrap may reuse
existing local credentials through its private credential writer; never reveal
credentials or commit them.

For first-time setup use [NEW_GAME.md](docs/NEW_GAME.md); for Studio connection
use [MCP_SETUP.md](docs/MCP_SETUP.md); for harness upgrades use
[HARNESS_UPGRADES.md](docs/HARNESS_UPGRADES.md). These instructions apply to Codex,
Claude, Cursor, and other coding agents. Product intent lives in GAME.md.
