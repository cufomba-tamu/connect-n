# Backlog

Status reflects the actual state of `main` plus open feature branches
as of this update. Story numbers match `docs/user_stories.md`. See the
[GitHub Project board](https://github.com/users/cufomba-tamu/projects/1)
for the authoritative live status/assignee/points view — this file is
the lightweight planning snapshot required alongside it.

| # | Story | Component | Status | Notes |
|---|-------|-----------|--------|-------|
| 1 | Drop a piece | Board | **Done** | `Board#drop_piece`/`column_full?` implemented and tested on `main`. |
| 2 | Detect a win | Board | **Done** | Win/draw checks rewritten to use a running streak count against `@win_length` instead of a hardcoded 4-window — correctly generalizes to any win length 3–10, verified by hand and by tests (win_length 3/4/10 covered for all directions, plus range-rejection tests). Merged to `main`. |
| 3 | Reject invalid move input | Game | **Done** | Merged via PR #14 (`game/reject-invalid-input`). |
| 4 | Configure the board | Board/Game | **Done** | Win-length prompt (`ask_dimensions`/`ask_win_length`) merged to `main` via PR #16, wired into `bin/play.rb`, `Board.new` accepts `win_length`. Verified end-to-end by hand with a Connect-3 game. |
| 5 | Track wins across sessions | Scoreboard | **Done** | `ScoreBoard` redesigned: persists to a JSON file and is keyed by player name instead of fixed `player1`/`player2` slots. Merged to `main` via PR #19. Verified by hand across two separate `ruby bin/play.rb` runs — win counts survived. |
| 6 | See the board clearly | Board | **Done** | `display_board` now prints a column-number header and shows marks as a single letter (e.g. `R`/`Y`) instead of the full word. Merged to `main` via PR #20. |
| 7 | Quit mid-game | Game | **Done** | Merged via PR #11 (`game/quit-mid-game`). |
| 8 | Play against the computer | Game | **Done** | `ComputerPlayer` (winning move, blocking move, center-favoring fallback) merged to `main` via PR #18, and `bin/play.rb` now actually asks "friend or computer" — reachable from the real game, not just specs. |
| 9 | Set up player identity | Player | **Done** | Merged via PR #10 (`player/player-identity`). |
| 10 | Play a full game from the terminal | Game | **Done** | GitHub issue #15 (this story was added later, so its issue number doesn't match its position in `user_stories.md`). `Game#play` detects a win or draw, ends the game, and records/displays the result via Scoreboard. Merged via PRs #16 and #19. |

All 10 stories are now Done and merged to `main`.

## Non-story tasks

| Task | Status | Notes |
|------|--------|-------|
| Draw detection | **Done** | Issue #12. `full?`/`draw?` implemented and tested; now correctly generalized along with `win?`. |
| Generalize win/draw checks to use win length instead of hardcoded 4 | **Done** | Fixed on `main` — see story 2. |
| `Board.new` accept `win_length` | **Done** | Fixed on `main` — see story 2. |
| Remove commented-out duplicate `column_full?` in `board.rb` | **Done** | Removed as part of Michael's win-detection commits, though `column_full?` got rewritten back to a more verbose if/else in the process. |
| Remove `main.rb` | **Done** | It was a stale scratch/demo script predating `bin/play.rb`, not part of the real app. Deleted after confirming it wasn't still needed. |
| Resolve `notes_tracker.txt` / `project_proposal` at repo root | **To Do** | Purpose never confirmed; check whether these should be moved into `docs/`, committed intentionally, or deleted. |
| Write `retrospective.md` | **Done** | All four sections written with real input from both of us; the last remaining required doc. |
| Rebase and reconcile `game/wire-full-game`, `game/configure-board`, `game/computer-opponent` | **Done** | All three reconciled and merged to `main` (PRs #16, #18). |
| `display_board` output is hard to read | **Done** | See story 6. |
| Correct GitHub Project board status for issues #5 and #6 | **Done** | Both were marked Done before the code actually matched; the code has since caught up, so those statuses are now accurate. |
| Fix merge commit `771e94c`'s message | **Won't fix** | Contains git's default template text instead of a real message. Already pushed to `main`; not worth rewriting shared history over, but worth being more careful with merge commits going forward. |
| Scoreboard redesign (persistence + name-keying) | **Done** | See story 5. |
| Set up RuboCop | **Done** | Gem, config (with a couple of justified exceptions), zero offenses. Merged via PR #20. |
| Wire up SimpleCov | **Done** | Was never actually started despite being in the Gemfile, so `coverage/` had been empty since the first commit. Fixed, and one genuinely untested branch (non-numeric win-length input) got a spec in the process. Line coverage is now 100%. |
| Bring `design.md` up to date | **Done** | Rewrote to reflect `ComputerPlayer`, the redesigned `Scoreboard`, generalized win detection, and the real `bin/play.rb` flow — removed every "planned"/"not yet" claim that had since become false. |
