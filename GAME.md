# Game

<!-- harness:uninitialized -->

## Vision
Describe the game in one sentence.

## Player fantasy
What should the player feel or become?

## Target devices and input
Primary devices:
Secondary devices:
Primary input:
Secondary input:

Interaction constraints: touch precision, simultaneous actions, small-screen UI,
orientation where relevant, and intentionally unsupported devices/input.

Device acceptance requirements: name the device classes, representative profiles,
and actual input paths that must be runtime-tested for the current milestone.
Support only the devices the product deliberately targets.

## Core gameplay loop
Describe the repeatable player actions and reward.

## V1 scope
List the smallest playable milestone and its measurable acceptance criteria.

## Explicit non-goals
Persistence, monetization, and frameworks until deliberately required.

## Game rules
Define wins, losses, limits, and tuning.

## Server-authoritative state
List trusted inventory, progression, rewards, purchases, and cooldowns.

## Client responsibilities
Input intent and presentation; shared modules carry no trusted mutable state.

## UI requirements
Define the information and interactions players need.

## Persistence requirements
None at baseline; decide explicitly before adding storage.

## Multiplayer assumptions
State player count and interaction rules before implementing them.

## Runtime acceptance scenarios
For each milestone: action, expected server/client state, visual result, errors.

## Current milestone
Define milestone 1 before asking the agent to implement it.

## Future ideas
Keep speculative ideas outside the current acceptance scope.
