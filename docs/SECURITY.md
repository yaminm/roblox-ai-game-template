# Security

The server owns inventory, currency, progression, rewards, purchases, cooldowns,
and persistence. Clients send intent and render replicated state. Shared code
is visible to clients and cannot protect secrets or trusted mutable state.

For every client-originated action, validate type, finite numeric values and
ranges, context/permission, target ownership/proximity, and rate/cooldown on the
server. Derive price and reward from server configuration. Reject invalid input
without partially mutating state. Test rejection paths as well as success.

Persistence is absent at baseline. Use isolated test data if a game adds it;
production DataStore/Open Cloud mutations require explicit human approval.
Inspect scripts in imported Creator Store assets before enabling them.
Keep credentials outside Git and logs. Publish/deploy and public/paid uploads
require human approval; local playtests do not publish a place.
