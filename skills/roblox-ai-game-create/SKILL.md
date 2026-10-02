---
name: roblox-ai-game-create
description: Create a Roblox game repository from a reviewed template release, implement an approved GAME.md milestone, or validate changed behavior through Studio MCP.
---

# Roblox AI Game Create

Turn an approved product contract into a verified playable change. If the game
direction or milestone is unsettled, use `$roblox-ai-game-plan` first. A user asking
to implement an existing GAME.md milestone already supplies product authorization;
do not repeat brainstorming or request the same approval again.

## Compatibility precedence and approved artifact

For an existing game, the precedence is:

`AGENTS.md / GAME.md / repository docs / .harness metadata > installed skill assumptions`.

Repository instructions, product intent, tool pins, and recorded provenance govern
work. Never automatically upgrade a game's harness, change its origin metadata, or
rewrite it to match the installed skill version. Harness upgrades are separate,
explicit assignments; this skill works with older generated games.

An existing repository's GAME.md is the canonical product contract. For a new game,
require the exact Approved GAME.md file/path or complete approved content. A fresh
conversation without that artifact must request it rather than reconstructing product
intent from vague memory or prior-chat assumptions.

In the same conversation, approval plus a request to proceed hands off directly from
`$roblox-ai-game-plan`: carry its approved artifact exactly and honor prior decisions
and authorization. Ask only about missing execution details, never re-brainstorm an
approved direction. Approval alone does not imply an implementation request.

## Establish the baseline

In an existing repository, read `AGENTS.md`, `GAME.md`, and their relevant linked
docs before editing; also read `CODEX_START_HERE.md` when present. Inspect status,
branch, recent history, local diffs, and any existing task PR. Follow that repository's
contract and preserve unrelated work. Continue on its intended task branch; create
`codex/<task>` when starting a normal implementation task on main.

For a new repository, establish the game name/location, approved milestone, intended
GitHub owner/account, and delivery scope. Reuse explicit choices from the session;
ask only for consequential missing information. Local-only rehearsal needs no remote.
Confirm account ownership before GitHub mutations; never substitute a work/personal
identity or expose credentials.

## Create from a released harness

Use the user-selected reviewed release tag; `v1.0.0` is the proven baseline. Verify
the published tag and commit rather than silently choosing a newer release or moving
template/main. For explicitly requested harness dogfooding, an exact PR candidate
commit may be used as a preview; record that commit/version and never describe it
as a published release. Follow its `docs/NEW_GAME.md` and `init-game --help`.
Example (replace the game directory, name, and intended GitHub account):

```sh
git clone --branch v1.0.0 git@github.com:yaminm/roblox-ai-game-template.git my-new-game
cd my-new-game
git remote rename origin template
git switch -c main
./scripts/init-game.sh --name "My New Game" --github-user yaminm
./scripts/bootstrap.sh
./scripts/verify.sh
```

Keep full shared history and the `template` remote. Run initialization on the clean
clone before transferring the Approved GAME.md byte for byte. Verify its SHA-256
before and after transfer; never amend product content during handoff. Repository
GAME.md becomes the sole canonical contract, superseding the external planning
artifact; move that file when appropriate and keep evidence copies non-authoritative.
Inspect naming, marker removal, and
`.harness/game.json`: `originHarnessVersion` must match the release and `templateCommit`
its exact commit. Preserve recorded provenance. Review the initialization diff, record
the approved contract, and verify/commit initialization before starting the task branch.
Read the generated repository contract and let its commands/configuration govern work.

When a remote game repository is part of the assignment, create it under the intended
owner as `origin`, preserving `template`. Honor the requested visibility; resolve it
before creating the remote. Harness upgrades remain intentional Git work described in
`docs/HARNESS_UPGRADES.md`, outside ordinary gameplay tasks.

## Implement and verify

Implement the smallest coherent milestone and update suitable unit tests for pure
rules and rejection paths. Keep strict Luau and the existing architecture. Product
intent belongs in GAME.md; edit Rojo-owned source on disk and sync through Rojo.
Never permanently edit Rojo-owned `Script.Source` through Studio MCP.

Keep trusted game state and action validation on the server; clients present state
and send intent. Validate remote input types, bounds, context, ownership, and rate
where relevant. Preserve Rokit as the tool manager and `./scripts/verify.sh` as the
canonical gate. Use the repository bootstrap/auth path for missing prerequisites;
treat setup friction as a defect. Fix it within the assignment or report a harness
follow-up; preserve published release tags and the canonical validation path.

Run `./scripts/verify.sh`. For runtime changes, complete the Studio procedure below.
Then self-review the entire task diff, including committed/staged/unstaged changes,
against acceptance criteria, authority, tests, ownership, scope, and accidental files.
Fix findings and repeat affected verification. A changed final revision needs new
evidence for the behavior it changed.

## Studio runtime acceptance

Gameplay, UI, physics, replication, hierarchy, remotes, characters, and other engine
behavior require actual Studio acceptance. For docs-only changes, record why runtime
testing is unnecessary. CI validates the repository; Studio validates runtime behavior.

Use the official Studio MCP server and the repository's `docs/MCP_SETUP.md` and
`docs/TESTING.md`. Build/open or sync the current source revision. Enumerate Studio
instances, explicitly select the intended file/ID, and inspect its mode and DataModel.
Preserve any unrelated running session; resolve an ambiguous target before acting.

1. Perform the documented generic smoke test; verify expected Rojo mounts and relevant
   source against disk. Fix mismatches through build/sync.
2. Start a real playtest; confirm server/client bootstrap, readiness, and a live character.
3. Exercise milestone acceptance through actual movement, touches, UI, or other player
   interactions. Observe authoritative server state and client presentation/HUD.
4. Inspect visuals when relevant, MCP Output, and server/client log histories for new
   errors/warnings. Record unexpected output and investigate before declaring a pass.
5. Remove temporary probes, stop the playtest even after a failed scenario, confirm
   Edit mode, and check that repository-owned source still matches disk.

Use probes to observe or drive player input, never to grant rewards or mutate trusted
state to manufacture acceptance. Record revision, actions, expected/observed results,
Output findings, and useful visual evidence. A build or fabricated state is insufficient.
If MCP, authentication, or another prerequisite is unavailable, finish independent
work and report the exact blocker and pending checks without claiming completion.

## Deliver and close the loop

After verification and self-review, commit only coherent task files, push normally,
and create/update the intended task PR when authorized or required by the repository
workflow. Use its PR template. Inspect the actual CI run for the pushed head, repair
failures within scope, and wait for a passed result before describing CI as passed.
Honor local-only assignments.

Existing explicit approval applies; otherwise merging, production publishing/data
mutations, secret changes, public/paid asset uploads, destructive Git operations, and
new dependencies/frameworks remain human gates under the repository contract.

After each major iteration, summarize changes, checks, findings, and remaining work
in the conversation. The final report gives the commit/PR, local and CI results,
actual Studio scenarios and Output, evidence, and remaining unverified limits.
