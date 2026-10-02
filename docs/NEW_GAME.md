# Create a game with shared template history

Install workstation prerequisites from TESTING.md and authenticate GitHub CLI
as the account that will own the game. Replace `yaminm` with your intended login
in the commands below. Git-local account preferences do not carry through a clone;
`--github-user` selects the bootstrap account explicitly without changing global
CLI authentication. For a real game, choose a published, reviewed harness release
tag (for example `v1.0.0`). Clone with full history and create a game branch from
that tag so future harness upgrades share ancestry:

Published v1.0.0 remains available. The v1.1.0 candidate adds optional planning/create
skills; use its release tag only after review, merge, and publication. Before creating
a game with those skills, approve one canonical GAME.md artifact. Creation transfers
it exactly after initialization; the generated repository contract then governs work.

```sh
git clone --branch v1.0.0 git@github.com:yaminm/roblox-ai-game-template.git my-new-game
cd my-new-game
git remote rename origin template
git switch -c main
./scripts/init-game.sh --name "My New Game" --github-user yaminm
./scripts/bootstrap.sh
./scripts/verify.sh
git add GAME.md README.md default.project.json src/shared/GameConfig.lua .harness-template .harness/game.json
git commit -m "chore: initialize My New Game"
gh repo create yaminm/my-new-game --private --source=. --remote=origin --push
```

Cloning a tag starts in detached HEAD; `git switch -c main` creates the game's
branch at that exact release commit. Choose an existing published tag; never assume
a candidate version such as `v1.1.0` has already been published.
`init-game` records the exact checked-out template commit, not a moving branch
name, in `.harness/game.json` alongside the originating harness version.

`init-game` requires a clean clone with a `template` remote and the uninitialized
marker. It changes game name/config/product/README, records harness origin in
`.harness/game.json`, and removes the marker. The optional account flag sets only `harness.githubUser` in local Git config.
It preserves history/remotes,
creates no gameplay, makes no network calls, and refuses reruns or dirty work.
It prints the next bootstrap/verification commands. Run `--help` for details.

Edit GAME.md with a small measurable milestone, then open `codex` and ask
“Implement milestone 1 from GAME.md.” Agent instructions are already in AGENTS.md.
Keep the `template` remote when `origin` is added for your game.

`template/main` is for harness development/testing and previewing unreleased
changes. Normal real-game creation should start from a reviewed release tag.
For a local rehearsal, clone the template checkout into a temporary directory,
rename `origin` to `template`, and follow the same initialization/verification
steps; no remote repository or publication is required. GitHub “Use this template”
is an alternative, but does not retain shared history. Add a `template` remote
manually and review/cherry-pick upgrades instead of assuming a normal merge.
