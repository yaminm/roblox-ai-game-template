# Task branches, review, and delivery

For a new game without a product contract, use the optional
[planning skill](../skills/roblox-ai-game-plan/SKILL.md), then the
[creation skill](../skills/roblox-ai-game-create/SKILL.md). Installation and the
starting workspace are described in the [README](../README.md#optional-codex-skills).
The Git-tracked skill files are authoritative; installed copies are local tools.
Review changes before updating installed copies; the skill installer refuses to
overwrite existing skill directories. An approved GAME.md milestone needs no new
brainstorming. After each major iteration, summarize changes, results, and remaining
work in the conversation; keep durable product intent in GAME.md.

## Human-driven mode

The user writes a milestone in GAME.md, opens `codex` in the repo, and requests
that milestone. AGENTS.md supplies implementation/verification requirements.
Use the intended task branch; if starting on `main`, create `codex/<task>` before
editing. Preserve unrelated local work and inspect any existing task PR first.

Implement → canonical gate → required Studio smoke/game acceptance → diff and
self-review → coherent commit → push → create/update one task PR → inspect CI →
human review/merge. This project expects a PR for a completed normal task unless
the user requests local-only work. Never merge by default.

Self-review the entire task diff against acceptance criteria, authority/input
validation, module boundaries, tests, ownership, whitespace, and accidental
files/secrets. Fix issues and repeat affected checks. Use `git diff --stat` and
`git diff <base>...HEAD` plus staged/unstaged diffs; inspect files themselves.

Commit only completed task files. Confirm the intended GitHub account before
push/PR operations (`gh api user --jq .login` or the connected GitHub account).
Do not substitute a work/personal identity without authorization. Push normally,
then `gh pr create` or `gh pr edit` the existing task PR; inspect its actual CI
run/checks and repair failures. A queued or running check is not a passed check.

## Autonomous assignment mode

Given scope and acceptance criteria, Codex can implement, test, run Studio MCP,
self-review, commit/push, update the task PR, and repair CI without repeated
setup instructions. Ask only for missing product intent or actions outside the
assignment. Both modes retain AGENTS.md's human approval gates for dependencies,
secrets, destructive operations, publication, production data, and merging.

If tools/authentication/Studio are unavailable, complete independent work and
report the specific blocker and unverified behavior. Do not invent verification.
PR descriptions report concrete behavior, commands/results, actual runtime
observations, and limits rather than session transcripts.
