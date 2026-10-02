"""Exercise initialization's repository safety boundary in disposable Git repos."""

import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]


class InitGameTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="init-game-test-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        for path in ["scripts/init-game.sh", "HARNESS_VERSION", "default.project.json", "README.md"]:
            target = self.root / path
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(ROOT / path, target)
        # Fixtures remain uninitialized even when these tests run in a generated game.
        (self.root / ".harness-template").write_text("roblox-ai-game-template:uninitialized\n")
        (self.root / "GAME.md").write_text("# Game\n\n<!-- harness:uninitialized -->\n\n## Vision\n")
        config = self.root / "src/shared/GameConfig.lua"
        config.parent.mkdir(parents=True)
        config.write_text('--!strict\n\nreturn table.freeze({\n\tName = "Roblox AI Game",\n})\n')
        project = self.root / "default.project.json"
        data = json.loads(project.read_text())
        data["name"] = "RobloxAIGameTemplate"
        project.write_text(json.dumps(data))
        self.git("init", "-q")
        self.git("config", "commit.gpgsign", "false")
        self.git("config", "user.name", "Harness test")
        self.git("config", "user.email", "test@example.invalid")
        self.git("add", ".")
        self.git("commit", "-qm", "fixture")
        self.git("remote", "add", "template", str(ROOT))

    def git(self, *arguments):
        return subprocess.check_output(["git", "-C", str(self.root), *arguments], text=True).strip()

    def run_init(self, *arguments):
        return subprocess.run(["bash", str(self.root / "scripts/init-game.sh"), *arguments],
                              capture_output=True, text=True, cwd="/tmp")

    def test_initializes_without_rewriting_history_or_remote(self):
        head = self.git("rev-parse", "HEAD")
        remote = self.git("remote", "get-url", "template")
        result = self.run_init("--name", 'Moon "Workshop" 🚀', "--github-user", "yaminm")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.git("rev-parse", "HEAD"), head)
        self.assertEqual(self.git("remote", "get-url", "template"), remote)
        self.assertEqual(self.git("config", "--local", "harness.githubUser"), "yaminm")
        self.assertEqual(json.loads((self.root / "default.project.json").read_text())["name"],
                         'Moon "Workshop" 🚀')
        origin = json.loads((self.root / ".harness/game.json").read_text())
        self.assertEqual(origin["templateCommit"], head)
        self.assertEqual(origin["originHarnessVersion"], (ROOT / "HARNESS_VERSION").read_text().strip())
        self.assertFalse((self.root / ".harness-template").exists())
        self.assertNotIn("harness:uninitialized", (self.root / "GAME.md").read_text())
        self.assertIn('Moon \\"Workshop\\" 🚀', (self.root / "src/shared/GameConfig.lua").read_text())
        self.git("add", ".")
        self.git("commit", "-qm", "initialize")
        result = self.run_init("--name", "Second Game")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Already initialized", result.stderr)
        self.assertEqual(self.git("status", "--porcelain"), "")

    def test_dirty_work_refused_without_mutations(self):
        (self.root / "notes.txt").write_text("keep user work\n")
        before = self.git("status", "--porcelain")
        result = self.run_init("--name", "Space Factory")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("dirty", result.stderr)
        self.assertEqual(self.git("status", "--porcelain"), before)

    def test_missing_template_remote_refused(self):
        self.git("remote", "remove", "template")
        result = self.run_init("--name", "Space Factory")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("remote rename", result.stderr)
        self.assertEqual(self.git("status", "--porcelain"), "")

    def test_invalid_name_and_customized_project_refused(self):
        for name in ["", " leading", "bad\nname", "x" * 81]:
            self.assertNotEqual(self.run_init("--name", name).returncode, 0)
            self.assertEqual(self.git("status", "--porcelain"), "")
        project = self.root / "default.project.json"
        data = json.loads(project.read_text())
        data["name"] = "User Game"
        project.write_text(json.dumps(data))
        self.git("add", ".")
        self.git("commit", "-qm", "customize")
        result = self.run_init("--name", "Space Factory")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("already customized", result.stderr)
        self.assertEqual(self.git("status", "--porcelain"), "")

    def test_help_is_read_only(self):
        result = self.run_init("--help")
        self.assertEqual(result.returncode, 0)
        self.assertIn("Usage:", result.stdout)
        self.assertEqual(self.git("status", "--porcelain"), "")


if __name__ == "__main__":
    unittest.main()
