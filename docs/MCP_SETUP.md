# Connect the official Studio MCP server

Install/update Roblox Studio. Enable **Assistant → … → Manage MCP Servers →
Enable Studio as MCP server** and use Quick connect for Codex CLI (or your agent).
The [official connection guide](https://create.roblox.com/docs/studio/mcp) is the
source for current platform-specific configuration. Avoid committing user-local
MCP configuration or absolute workstation paths to the repository.

For manual stdio setup, macOS uses
`/Applications/RobloxStudio.app/Contents/MacOS/StudioMCP`; Windows uses
`cmd.exe /c %LOCALAPPDATA%\Roblox\mcp.bat`. Quick connect can configure Codex,
Claude, or Cursor without a repository-specific adapter. Restart the client if
its tools do not refresh.

Build with `./scripts/verify.sh`, open `build/game.rbxlx`, and enable MCP in that
instance. For live sync run `rojo serve default.project.json` and connect the
Rojo Studio plugin. Use the matching pinned Rojo CLI/plugin major version.

A successful MCP initialization alone is insufficient. Call `list_roblox_studios`,
select the intended name/ID, then successfully inspect its DataModel. Multiple
windows require explicit instance selection on every call. Empty tool lists or
missing intended instances mean runtime verification is pending. Do not mutate
an unrelated open place. See TESTING.md for the smoke and acceptance procedure.
