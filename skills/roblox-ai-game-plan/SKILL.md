---
name: roblox-ai-game-plan
description: Brainstorm Roblox game ideas or turn an unsettled concept into an approved GAME.md milestone before repository creation or gameplay implementation.
---

# Roblox AI Game Planning

Help the user choose a game worth prototyping and define its smallest testable
milestone. Planning owns product decisions; `$roblox-ai-game-create` owns repository
creation, implementation, and verification.

## Discover what is already decided

Use the user's answers and any existing `GAME.md` before asking questions. An
approved milestone can go straight to creation; refine only unresolved product
decisions. Preserve the chosen genre, audience, and constraints.

Interview conversationally, with at most three focused questions per round.
Start with the premise or desire for suggestions, intended players/devices, and
available time/team/assets. Offer examples and a recommendation when the user
does not know; do not require a beginner to invent a core loop.

As needed, resolve the player fantasy, reference games, first-minute experience,
repeatable actions and choices, progression, social play, persistence, and
monetization boundaries. Ask only what would change the recommendation or V1.
Mark suggested defaults as assumptions rather than confirmed requirements.

## Suggest and challenge concepts

For an open premise, offer two or three distinct concepts. For a specific idea,
improve that idea and offer alternatives only when they clarify a real tradeoff.
Use compact comparisons covering:

- the hook, player fantasy, and first-minute action;
- action → meaningful choice → feedback → reason to replay;
- the differentiator and a voluntary social/shareable moment;
- the smallest playable milestone and what to cut from it;
- the riskiest fun assumption and a cheap way to test it;
- production cost, Roblox performance, and abuse/moderation concerns that affect V1.

Recommend a direction using designer, producer, Roblox engineer, and growth
perspectives. Favor readable feedback, mastery/discovery/expression, accessible
controls, feasible content production, and social value that comes from play.
Treat replayability and viral reach as hypotheses. Avoid coercive retention,
gambling-like rewards, and exploitative spending mechanics for young players.

Browse primary sources when current trends, platform rules, monetization policy,
or market claims matter; distinguish evidence from inference. Otherwise work from
the user's references and describe uncertain design ideas as hypotheses.

## Agree on the product contract

Present the proposed direction and milestone for approval, honoring decisions
already approved in the conversation. Before handoff, the agreed contract must
identify the player, core loop, V1 boundaries, and measurable acceptance criteria.
Leave future features outside the milestone and label remaining open decisions.

Use the repository's `GAME.md` structure when it exists. Include:

- vision, audience/device assumptions, and first-minute experience;
- core loop, rules, V1 scope, and explicit non-goals;
- trusted server state, client responsibilities, and visible feedback/UI;
- multiplayer, persistence, and monetization requirements, including deliberate omissions;
- the current milestone with real player actions and expected server/client results;
- important rejection/failure cases and one hypothesis for a human fun playtest.

Keep engineering acceptance separate from fun hypotheses: Studio MCP can prove
behavior, while player observation is needed to assess clarity and desire to replay.

## One approved GAME.md and direct handoff

Maintain exactly one canonical Approved GAME.md. In an existing game, repository
`GAME.md` is authoritative; read its agent contract and preserve existing work before
editing. For a new game, write one `GAME.md` planning artifact outside the future
template clone (for example, `.game-plans/<slug>/GAME.md` in the games' parent folder).
If writing an artifact is unavailable, provide its complete Markdown content.

Present that exact artifact/content for approval. Approval applies to its specific
revision; record the path and SHA-256 when a file exists. A direction choice alone
does not approve product decisions added afterward. Label unapproved work as a draft.

When the user approves and asks to proceed in this conversation, load and immediately
continue with `$roblox-ai-game-create`, carrying the exact Approved GAME.md and known
delivery preferences. Do not ask them to repeat the plan, invoke the creator manually,
or reopen approved choices. Approval without a request to proceed ends at planning.

Creator initializes a clean clone first, transfers the approved bytes into repository
`GAME.md`, verifies fidelity, and makes that file the sole canonical contract. Retire
the external planning artifact's canonical role; retained evidence is non-authoritative.

For a fresh conversation without an existing game repository, the handoff must include
the explicit approved artifact path or full content and its approval status. Never
reconstruct it from vague memory, a summary, or assumed access to an earlier chat.
For an existing repository, continue from its GAME.md rather than an external copy.

If approval is pending, report a draft rather than an approved plan. Planning alone
does not authorize repository creation, gameplay changes, or publication. After each
major iteration, summarize decisions, changes, open questions, and the next step
in the conversation; store durable product intent in GAME.md rather than session notes.
