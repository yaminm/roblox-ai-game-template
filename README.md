# Roblox AI Game Template v1

A small Git + Rojo + Rokit harness for Roblox games, with Codex as a development
agent. No runtime packages or gameplay framework are included.

[Create a game](docs/NEW_GAME.md) → edit [GAME.md](GAME.md) → open `codex` →
ask “Implement milestone 1 from GAME.md.” [AGENTS.md](AGENTS.md) supplies the
repository contract; [CODEX_WORKFLOW.md](docs/CODEX_WORKFLOW.md) explains the loop.

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
