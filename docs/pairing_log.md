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
