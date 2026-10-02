#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  cat <<'HELP'
Usage: ./scripts/init-game.sh --name "My New Game"

Initialize game-owned files in a clean, uninitialized template clone.
Requires Git, Python 3, and a remote named template. Preserves history/remotes.
Refuses dirty work or reruns. Does not install tools, create a remote, or publish.
Next: ./scripts/bootstrap.sh && ./scripts/verify.sh, then review and commit.
HELP
  exit 0
fi
for prerequisite in git python3; do
  if ! command -v "$prerequisite" >/dev/null; then
    echo "Missing prerequisite: $prerequisite" >&2
    exit 1
  fi
done
cd "$(dirname "$0")/.."
python3 - "$@" <<'PY'
import argparse
import json
from pathlib import Path
import re
import subprocess
import sys

parser = argparse.ArgumentParser(description="Initialize a clean template clone")
parser.add_argument("--name", required=True)
arguments = parser.parse_args()
name = arguments.name
if not name.strip() or name != name.strip() or len(name) > 80 or any(ord(c) < 32 for c in name):
    sys.exit("Game name must be 1-80 characters, without control characters or surrounding spaces.")


def git(*args):
    result = subprocess.run(["git", *args], capture_output=True, text=True)
    if result.returncode:
        sys.exit("Git prerequisite failed: " + " ".join(args))
    return result.stdout.strip()


root = Path.cwd().resolve()
if Path(git("rev-parse", "--show-toplevel")).resolve() != root:
    sys.exit("Run the script from its own template repository, not a nested copy.")
marker = root / ".harness-template"
if not marker.exists() or marker.read_text() != "roblox-ai-game-template:uninitialized\n":
    sys.exit("Already initialized or not an uninitialized template clone; refusing changes.")
if git("status", "--porcelain", "--untracked-files=all"):
    sys.exit("Working tree is dirty; review and commit/stash your work before initialization.")
if "template" not in git("remote").splitlines():
    sys.exit("Retain the upstream remote first: git remote rename origin template")
if (root / ".harness/game.json").exists():
    sys.exit("Game initialization metadata already exists; refusing changes.")

try:
    version = (root / "HARNESS_VERSION").read_text().strip()
    if not re.fullmatch(r"\d+\.\d+\.\d+", version):
        raise ValueError("Invalid HARNESS_VERSION")
    project = json.loads((root / "default.project.json").read_text())
    if project["name"] != "RobloxAIGameTemplate":
        raise ValueError("Project name was already customized")
    contract = (root / "GAME.md").read_text()
    if "<!-- harness:uninitialized -->" not in contract:
        raise ValueError("GAME.md was already customized")
    config = (root / "src/shared/GameConfig.lua").read_text()
    if config != '--!strict\n\nreturn table.freeze({\n\tName = "Roblox AI Game",\n})\n':
        raise ValueError("GameConfig was already customized")
except (KeyError, ValueError, OSError) as error:
    sys.exit(f"Invalid template state: {error}; no files changed.")

project["name"] = name
updates = {
    "default.project.json": json.dumps(project, indent=2, ensure_ascii=False) + "\n",
    "GAME.md": contract.replace("# Game\n", f"# {name}\n", 1).replace("<!-- harness:uninitialized -->\n\n", ""),
    "src/shared/GameConfig.lua": config.replace('"Roblox AI Game"', json.dumps(name, ensure_ascii=False)),
    "README.md": f'''# {name}

Define milestones in [GAME.md](GAME.md). Coding agents follow [AGENTS.md](AGENTS.md).

```sh
./scripts/bootstrap.sh
./scripts/verify.sh
rojo serve default.project.json
codex
```

Open `build/game.rbxlx` or connect the Rojo plugin, then use
[Studio MCP](docs/MCP_SETUP.md) for runtime acceptance.
[Testing](docs/TESTING.md) · [Workflow](docs/CODEX_WORKFLOW.md) ·
[Harness upgrades](docs/HARNESS_UPGRADES.md).
''',
    ".harness/game.json": json.dumps({"name": name, "originHarnessVersion": version,
        "templateCommit": git("rev-parse", "HEAD")}, indent=2, ensure_ascii=False) + "\n",
}
# All preconditions are checked before writing game-owned files.
for path, content in updates.items():
    target = root / path
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(content)
marker.unlink()
print(f"Initialized {name}; Git history and template remote preserved.")
print("Review GAME.md, then run ./scripts/bootstrap.sh and ./scripts/verify.sh.")
print("Review the diff and commit initialization before creating/pushing your game repository.")
PY
