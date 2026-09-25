# Planning

See also `docs/project_proposal.md` — the original proposal written at
the very start of the project (2026-09-11), before any code existed.
This file restates/updates that planning in light of how the project
actually turned out.

## What we're building

Connect N: a terminal-based, two-player Connect Four variant with a
configurable win length. Two players alternate dropping pieces into a
column; pieces fall to the lowest open row under gravity. First player
to connect their chosen number of pieces in a row (horizontal,
vertical, or diagonal) wins. Win counts persist across sessions in a
local scoreboard file.

## Essential vs. optional features

Essential (must work for the app to be a real, playable game):
- Drop a piece into a column (story #1)
- Detect a win (story #2)
- Reject invalid move input (story #3)

Everything else is important but not blocking a minimally playable
game, and is scoped as its own story in `docs/user_stories.md`:
configuring the board (#4), tracking wins across sessions (#5), seeing
the board clearly (#6), quitting mid-game (#7), player identity (#9),
and wiring the full game together end-to-end (#10).

Optional/stretch:
- Play against the computer (story #8)

## How we're collaborating

A mix of individual work and pair programming. The natural split has
been Chibuzo on the `Game`/`Player` side, Michael on the `Board` side,
with foundational/setup work (initial project structure, first-pass
`Board`, `Player`, and `Game#ask_column`) done together in a pairing
session, and most story-specific work since done individually on
feature branches, then reviewed at merge time.

## What "done" means

**For an individual story:** its acceptance criteria (in
`docs/user_stories.md`) are actually met, it has passing specs (happy
and sad path where relevant), and it's merged to `main` via a PR. We
use `Closes #N` in the PR description only when the story is genuinely
complete against its criteria; otherwise `Refs #N`, and the Issue stays
at In Progress with a comment noting what's done vs. pending.

**For the project overall:** all essential stories are implemented and
merged, the app is actually playable end-to-end via `bin/play.rb`, the
test suite passes with meaningful coverage of core logic, and the
required docs (`README.md`, `docs/design.md`, `docs/backlog.md`,
`docs/planning.md`, `docs/retrospective.md`, `docs/pairing_log.md`)
are present and accurate. Stretch features (like the computer
opponent) are a bonus, not a requirement for "done."
