# Roblox AI Game Template v1

A small Git + Rojo + Rokit harness for Roblox games, with Codex as a development
agent. No runtime packages or gameplay framework are included.

[Create a game](docs/NEW_GAME.md) → edit [GAME.md](GAME.md) → open `codex` →
ask “Implement milestone 1 from GAME.md.” [AGENTS.md](AGENTS.md) supplies the
repository contract; [CODEX_WORKFLOW.md](docs/CODEX_WORKFLOW.md) explains the loop.

## Optional Codex skills

The versioned [planning skill](skills/roblox-ai-game-plan/SKILL.md) helps brainstorm
and approve a small GAME.md milestone. The [creation skill](skills/roblox-ai-game-create/SKILL.md)
creates a game from a reviewed harness release and follows the implementation,
verification, Studio MCP, and PR workflow. Install both once for use across games:

```text
$skill-installer
Install both skills from yaminm/roblox-ai-game-template at a reviewed revision
containing them: skills/roblox-ai-game-plan and skills/roblox-ai-game-create.
```

Start a fresh conversation from your games' parent directory with
`$roblox-ai-game-plan`, then use `$roblox-ai-game-create` after approving the plan.
For later work, open the created game's repository and request its GAME.md milestone.
Skills are optional; AGENTS.md remains the repository contract. The published
`v1.0.0` release predates these skill files and remains unchanged.

## Repository verification

```sh
./scripts/bootstrap.sh
./scripts/verify.sh
rojo serve default.project.json
```

Open `build/game.rbxlx` in Studio, or connect the Rojo plugin to the local server.
[Set up official Studio MCP](docs/MCP_SETUP.md) for runtime validation.
CI runs the same repository gate; Studio runs the actual engine playtest.

Requires Git, Python 3, Bash, and Rokit 1.2.0. macOS and Ubuntu are the supported
shell environments; Studio runtime validation requires macOS or Windows.
Windows users can run shell verification in WSL and Studio on Windows (Rojo
network bridging must be configured separately).

The harness version is in [HARNESS_VERSION](HARNESS_VERSION).
[Upgrade intentionally through Git](docs/HARNESS_UPGRADES.md), retaining the
`template` remote and shared history.
