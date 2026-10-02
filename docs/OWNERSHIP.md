# Ownership and upgrade boundaries

Git owns source, tests, configuration, durable docs, and reproducible world
objects. Rojo maps those files into Studio. Edit their source on disk and sync
or rebuild. Never use MCP or Script Sync as a second editor for Rojo-owned scripts.

Studio owns transient playtest state and manually authored assets outside Rojo
mounts. Before keeping a Studio edit, choose a durable repository/asset
representation and document its owner. Remove temporary probes before stopping.

| Ownership | Files |
| --- | --- |
| Harness | `.github/workflows/`, `rokit.toml`, `.luaurc`, `selene.toml`, `stylua.toml`, `.editorconfig`, `HARNESS_VERSION`, `scripts/`, `tests/harness/`, `tooling/`, `AGENTS.md`, `CLAUDE.md`, generic setup/testing/security/workflow/upgrade docs |
| Game | `GAME.md`, `src/`, `tests/unit/`, game ADRs, `docs/ARCHITECTURE.md`, game evidence and assets |
| Shared | `default.project.json` (harness mounts plus game name/world), `.gitignore`, `README.md` (game onboarding), `.harness/game.json` (initialization provenance) |

Harness ownership means review reusable changes during upgrades, not immunity
from game needs. Preserve game-specific modifications and merge intentionally.
See HARNESS_UPGRADES.md for the workflow.
