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
| 4 | Configure the board | Board/Game | **In Progress** | `Board.new` now accepts `win_length` (done, on `main`). Still pending: `game/configure-board`'s win-length prompt needs to be rebased onto the current `main` and actually wired into `bin/play.rb`. |
| 5 | Track wins across sessions | Scoreboard | **In Progress** | `ScoreBoard` now exists but is in-memory only (no file, resets every run) and keyed by fixed `player1`/`player2` slots instead of player name. Doesn't meet "persists across sessions" yet — Michael is redesigning it. |
| 6 | See the board clearly | Board | **In Progress** | `display_board` renders the grid, but doesn't yet label columns with numbers (part of the story's acceptance criteria). |
| 7 | Quit mid-game | Game | **Done** | Merged via PR #11 (`game/quit-mid-game`). |
| 8 | Play against the computer | Game | **In Progress** | `ComputerPlayer` (winning move, blocking move, center-favoring fallback) built and tested on `game/computer-opponent`, branched off `game/wire-full-game`. Not yet merged; now needs a rebase onto current `main` to pick up the win-length fix. |
| 9 | Set up player identity | Player | **Done** | Merged via PR #10 (`player/player-identity`). |
| 10 | Play a full game from the terminal | Game | **In Progress** | `Game#play` detects a win or draw and ends the game (implemented, tested, PR open referencing this issue). Branch needs a rebase onto current `main`. Still pending: Scoreboard isn't hooked in, and `bin/play.rb` still hardcodes a 6x7 board with no win-length prompt connected. |

## Non-story tasks

| Task | Status | Notes |
|------|--------|-------|
| Draw detection | **Done** | Issue #12. `full?`/`draw?` implemented and tested; now correctly generalized along with `win?`. |
| Generalize win/draw checks to use win length instead of hardcoded 4 | **Done** | Fixed on `main` — see story 2. |
| `Board.new` accept `win_length` | **Done** | Fixed on `main` — see story 2. |
| Remove commented-out duplicate `column_full?` in `board.rb` | **Done** | Removed as part of Michael's win-detection commits, though `column_full?` got rewritten back to a more verbose if/else in the process. |
| Confirm `main.rb`/`board.display` cleanup with Michael | **Resolved** | `main.rb` correctly calls `board.display_board` now. The file itself is still a stale leftover script (predates `bin/play.rb`), not part of the real app — Michael's using it as a manual scratch/demo script for `Board`/`Scoreboard`. |
| Resolve `notes_tracker.txt` / `project_proposal` at repo root | **To Do** | Purpose never confirmed; check whether these should be moved into `docs/`, committed intentionally, or deleted. |
| Missing planning docs (`retrospective.md`) | **In Progress** | "What Went Well" section written; three sections still need real input. `planning.md` and `pairing_log.md` are both done. |
| Rebase `game/wire-full-game`, `game/configure-board`, and `game/computer-opponent` onto current `main` | **To Do** | All three predate the win-length fix. `game/configure-board` and `game/wire-full-game` also independently touch `bin/play.rb`/`game.rb` and will need manual reconciliation with each other, not just a mechanical rebase. |
| `display_board` output is hard to read | **To Do** | No column-number header, and marks print as full words (e.g. `red`/`yellow`) instead of single characters — makes rows uneven and cluttered. Part of story #6, not yet fixed. |
| Fix merge commit `771e94c`'s message | **Won't fix** | Contains git's default template text instead of a real message. Already pushed to `main`; not worth rewriting shared history over, but worth being more careful with merge commits going forward. |
| Scoreboard redesign (persistence + name-keying) | **To Do** | Still Michael's other open item — untouched by the win-length fix. |

## Icebox / ideas not yet stories

- Configurable player colors/marks beyond red/yellow.
- Persisting more than win counts (e.g. games played, win streaks) in
  `Scoreboard`.
