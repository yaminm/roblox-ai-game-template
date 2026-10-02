# Architecture

`src/server` maps to `ServerScriptService.Server`; `src/client` maps to
`StarterPlayer.StarterPlayerScripts.Client`; `src/shared` maps to
`ReplicatedStorage.Shared`. Both entry points load immutable `GameConfig`.
The baseline only marks `ServerReady` / local `ClientReady` and prints bootstrap
messages. It provides a baseplate and spawn, no gameplay or remotes.

Use explicit typed modules. Put engine-independent rules in shared/server
modules that Lune unit tests can load. Server modules own trusted mutable state;
client modules own input and presentation. Introduce remotes only for required
client intent and follow SECURITY.md. Keep services and dependencies explicit.

This file becomes game-owned after initialization. Update it when game modules
or communication boundaries change. Record consequential tradeoffs in
`docs/decisions/`; an ADR should explain context, choice, and consequences.
