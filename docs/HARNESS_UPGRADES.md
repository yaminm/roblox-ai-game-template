# Version and upgrade the harness

HARNESS_VERSION is the reviewed harness version currently incorporated.
`init-game` records the starting version and template commit in `.harness/game.json`;
keep that provenance unchanged. Tool pins are independent explicit decisions.

Template maintainers propose harness changes in PRs, update HARNESS_VERSION,
validate the repository and a fresh consumer, and merge only with authorization.
After approval, tag reviewed releases `v1.0.0`, `v1.1.0`, etc. Do not tag an
unmerged proposal as a release. Patch versions fix compatible defects; minor
versions add compatible harness capabilities; major versions change contracts.
Release/PR descriptions provide the changelog and migration notes.

The v1.1.0 candidate adds the optional `skills/roblox-ai-game-plan/` and
`skills/roblox-ai-game-create/` capabilities: conversational discovery, one approved
GAME.md artifact, direct creation handoff, and explicit repository compatibility
precedence. This compatible capability addition uses a minor version bump. It does
not change tool pins or gameplay. Keep v1.0.0 immutable; v1.1.0 is tagged only after
review and merge. Installing new skills alone never upgrades an existing game or
changes its HARNESS_VERSION/provenance.

In a game repository:

```sh
git fetch template --tags
git log --oneline HEAD..template/main
git diff v1.0.0 v1.1.0 -- scripts/ skills/ tooling/ rokit.toml .github/ AGENTS.md docs/
git switch -c chore/harness-upgrade
```

Use available published tags; these names illustrate the release convention.
Review the release diff and OWNERSHIP.md, then cherry-pick selected harness
commits or merge the reviewed release when appropriate. A release may include
game starter changes: preserve your GAME.md, src, tests, architecture, and
custom world mounts. Resolve shared-file conflicts deliberately; never blindly
overwrite game-owned files. For a cherry-pick containing unwanted starter changes,
use `git cherry-pick --no-commit <commit>`, reconcile the diff, and commit the
reviewed result. Update HARNESS_VERSION only when its documented changes are
incorporated; explain partial upgrades in the upgrade PR.

Run bootstrap for changed pins/definitions, then `./scripts/verify.sh` with the
upgrade base. Perform Studio smoke and game runtime regressions if runtime
behavior, mappings, or tooling output changes. Self-review, push, open an upgrade
PR, and wait for passing CI and human review. Standard Git is the update mechanism;
there is no automatic update service or custom migration framework.
