# Pairing Log

## Session 1 — 2026-09-11

Driver / Navigator: Chibuzo Ufomba and Michael Zhou, roles switched over
the course of the session.

Work completed:
- Set up the initial project structure, `Gemfile`/`Gemfile.lock`,
  pinned Ruby version, moved `README.md` to project root
- Added the first pass of `docs/user_stories.md`
- Built the initial `Board` class (grid setup, `display_board`) with
  specs
- Built the `Player` class (`name`/`mark`) with specs
- Built `Game#ask_column` with quit (`q`) handling and a spec

Notes:
- Established the `input:`/`output:` keyword-argument pattern on
  `Game` methods (defaulting to `$stdin`/`$stdout`) so specs can pass
  `StringIO` instead of stubbing global I/O — carried forward as the
  convention for all later interactive `Game` methods.
- This was the project's initial setup session — most of the
  foundational classes (`Board`, `Player`, `Game`) were scaffolded
  this day, which later sessions built on.

## Session 2 — 2026-09-23

Driver: Chibuzo Ufomba
Navigator: Michael Zhou

Work completed:
- Reviewed Michael's win-detection and Scoreboard commits on `main`
  together and identified two gaps: win/draw checks hardcode a
  4-piece window instead of using a configurable win length, and
  `Scoreboard` is in-memory only (not persistent, not keyed by player
  name)
- Rebased `game/wire-full-game` onto `main` and wired real win/draw
  detection into `Game#play`, with specs; opened a PR referencing
  issue #10
- Reviewed `game/configure-board` for the same gaps
- Updated `README.md`: fixed the "running the game" placeholder,
  added a features list and a known-limitations section

Notes:
- Agreed Michael will take the win-length generalization and the
  Scoreboard redesign (persistence + name-keying) as next steps, since
  both are in his area of the codebase.
- The win-length and win/draw-wiring work are independent — win/draw
  wiring didn't need to wait on the win-length fix, so it was done
  first while that's still in progress.

## Session 3 — 2026-09-25

Driver: Michael Zhou
Navigator: Chibuzo Ufomba

Work completed:
- Manually tested the full game end to end: different win lengths,
  playing against a friend and against the computer, and confirming
  scoreboard persistence across separate runs
- Wrote the script for the class presentation

Notes:
- By this session, all 10 user stories were done and merged, so
  testing focused on confirming real playthroughs matched the
  documented behavior rather than finding new gaps.
