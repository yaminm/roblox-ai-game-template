# Roblox AI Development Harness — Canonical Context

## Why this repository exists

This is not primarily a Roblox game framework. It is a reusable, professional AI-first development harness for creating many Roblox games with coding agents such as Codex, Claude Code, or Cursor.

The core design goal is dependable agent execution: an agent should be able to understand a task, implement it, verify it statically, sync it into Roblox Studio, playtest it through Roblox Studio MCP, observe failures, fix them, and provide evidence before declaring completion.

The template should optimize for repeatability, inspectability, low ambiguity, safe autonomy, and easy debugging rather than maximum framework abstraction.

## Decisions already made

### 1. Filesystem-first source control

Git is canonical for source code, configuration, tests, durable documentation, and reproducible/simple world definitions.

Rojo is the default filesystem-to-Studio bridge because we want a repo-first workflow that coding agents can search, diff, edit, test, and review normally.

Do not use Roblox Script Sync on scripts already owned by Rojo.

### 2. Roblox Studio remains the engine truth

Roblox Studio is the real runtime and visual environment. The filesystem does not replace the engine.

Use the official Roblox Studio MCP as the agent's runtime/visual interface for:
- inspecting the DataModel;
- running temporary Luau probes;
- starting/stopping playtests;
- reading Output;
- interacting with gameplay/UI;
- screenshots/visual verification;
- temporary test objects;
- asset/world workflows that genuinely belong in Studio.

MCP must not become a second persistent code editor for Rojo-owned Script.Source.

### 3. Native typed Luau

Use native Luau, normally with `--!strict`.

Do not introduce roblox-ts by default. Keeping the implementation language equal to the runtime/debugging language reduces translation layers for humans and agents.

### 4. Framework-light baseline

The template intentionally does not start with Knit, a DI framework, a state framework, React, a networking framework, or a persistence framework.

Prefer explicit modules and clear server/client/shared boundaries. Add a framework only when a concrete game requirement justifies the extra abstraction and debugging complexity.

### 5. Server authority by default

Clients send intent and render presentation. The server owns authoritative gameplay state, economy, progression, rewards, purchases, cooldowns, and security-sensitive validation.

Every client-originated action must be validated server-side for type, value/range, permission/context, and rate where appropriate.

### 6. Agent policy is source code

`AGENTS.md` is the canonical operational contract for coding agents. Harness-specific adapters such as `CLAUDE.md` should reuse/import the same policy rather than duplicate it.

Durable context belongs in a small set of repository documents, not in ephemeral prompts or dozens of planning files.

### 7. Verification is part of implementation

A plausible code diff is not completion.

Fast verification should include formatting, linting, static/type analysis, unit tests, and a Rojo build.

Runtime/gameplay/visual work must also be verified in Roblox Studio via MCP. The agent should play the changed behavior, inspect Output, and provide evidence. Visual changes should be inspected visually.

If MCP/Studio verification is unavailable, the agent must explicitly say runtime verification is pending rather than claim success.

### 8. Same checks locally and in CI

Prefer repository commands/scripts that both humans, agents, and CI invoke instead of separate agent-only and CI-only workflows.

Tool versions are pinned with Rokit. Supporting tools include Rojo, Lune, Luau LSP, StyLua, and Selene. Runtime dependencies should remain minimal.

### 9. Controlled autonomy

Safe/read-only/local actions should be automatable. Production-impacting or destructive actions require explicit human approval.

Examples requiring approval:
- production publishing/deployment;
- production DataStore/Open Cloud mutations;
- public/paid asset uploads;
- adding/upgrading dependencies;
- force push / destructive Git operations;
- broad destructive filesystem operations.

Studio must not point to production persistence by default.

### 10. Third-party assets are untrusted

Creator Store models may contain scripts. Imported content must be inspected before enabling embedded code.

## Intended agent loop

1. Read `AGENTS.md` and relevant durable docs.
2. Understand the requested behavior and acceptance criteria.
3. Make the smallest coherent filesystem change.
4. Run fast repository verification.
5. Sync through Rojo.
6. Inspect the relevant DataModel state through Studio MCP.
7. Playtest the changed behavior.
8. Inspect Output and visual/gameplay evidence.
9. Fix failures and repeat.
10. Report changes, verification evidence, and remaining risks.

## Template philosophy

The reusable value of this repository is the development harness and guardrails, not a prebuilt gameplay architecture.

Prefer:
- explicit contracts over magic;
- executable guardrails over long prompts;
- evidence over confident completion claims;
- one source of truth per artifact;
- small testable modules over premature abstractions;
- a builder + reviewer/tester pattern over many agents writing the same feature concurrently.

For parallel agent work, isolate writers using separate Git worktrees/branches and separate Studio sessions rather than allowing several writers to mutate one working tree/Studio state.

## Validation strategy

Changes to this template should be exercised against a separate real game created from it. The current validation project is `yaminm/roblox-ai-template-validation`, using a small game called Crystal Rush.

The validation game exists to stress the harness — server/client boundaries, remotes, UI, world state, multiplayer-ready logic, security, testing, Rojo sync, MCP playtesting, and visual evidence — without becoming a production game itself.

## Current objective

The next milestone is not feature expansion. It is proving the end-to-end harness on a real workstation with Codex + Git + pinned tools + Rojo + Roblox Studio MCP.

The template is considered proven only after a coding agent can enter the validation repository with a short task, discover the repository rules itself, run the required checks, connect to Studio, exercise gameplay, diagnose problems, repair them, and produce an evidence-based completion report without extensive ad-hoc prompting.