# Backlog

Status reflects the actual state of `main` plus open feature branches
as of this update. Story numbers match `docs/user_stories.md`. See the
[GitHub Project board](https://github.com/users/cufomba-tamu/projects/1)
for the authoritative live status/assignee/points view — this file is
the lightweight planning snapshot required alongside it.

| # | Story | Component | Status | Notes |
|---|-------|-----------|--------|-------|
| 1 | Drop a piece | Board | **Done** | `Board#drop_piece`/`column_full?` implemented and tested on `main`. |
| 2 | Detect a win | Board | **In Progress** | Horizontal/vertical/diagonal checks are implemented and tested (Issue #2), but hardcode a 4-piece window instead of a configurable win length. Doesn't yet meet the "works for any win length" acceptance criterion. |
| 3 | Reject invalid move input | Game | **Done** | Merged via PR #14 (`game/reject-invalid-input`). |
| 4 | Configure the board | Board/Game | **In Progress** | Redesigned to derive board size from win length `N` (`game/configure-board` branch). `Board.new` doesn't yet accept `win_length` — needs to be threaded through before this closes. Acceptance criteria changed from the original story; needs Michael's sign-off. |
| 5 | Track wins across sessions | Scoreboard | **In Progress** | `ScoreBoard` now exists but is in-memory only (no file, resets every run) and keyed by fixed `player1`/`player2` slots instead of player name. Doesn't meet "persists across sessions" yet — Michael is redesigning it. |
| 6 | See the board clearly | Board | **In Progress** | `display_board` renders the grid, but doesn't yet label columns with numbers (part of the story's acceptance criteria). |
| 7 | Quit mid-game | Game | **Done** | Merged via PR #11 (`game/quit-mid-game`). |
| 8 | Play against the computer | Game | **In Progress** | `ComputerPlayer` (winning move, blocking move, center-favoring fallback) built and tested on `game/computer-opponent`, branched off `game/wire-full-game`. Not yet merged; inherits the same hardcoded-4 win-detection limitation as the rest of the app until that's fixed. |
| 9 | Set up player identity | Player | **Done** | Merged via PR #10 (`player/player-identity`). |
| 10 | Play a full game from the terminal | Game | **In Progress** | `Game#play` now detects a win or draw and ends the game (implemented, tested, PR open referencing this issue). Still pending: Scoreboard isn't hooked in, and `bin/play.rb` still hardcodes a 6x7 board with no win-length prompt connected. |

## Non-story tasks

| Task | Status | Notes |
|------|--------|-------|
| Draw detection | **Done** | Issue #12. `full?`/`draw?` implemented and tested, but depends on `win?`, which shares story 2's hardcoded-4 issue. |
| Generalize win/draw checks to use win length instead of hardcoded 4 | **To Do** | Needed for story 2 and the board-configuration redesign to actually line up. |
| `Board.new` accept `win_length` | **To Do** | Needed for the above. |
| Remove commented-out duplicate `column_full?` in `board.rb` | **Done** | Removed as part of Michael's win-detection commits, though `column_full?` got rewritten back to a more verbose if/else in the process. |
| Confirm `main.rb`/`board.display` cleanup with Michael | **Resolved** | `main.rb` correctly calls `board.display_board` now. The file itself is still a stale leftover script (predates `bin/play.rb`), not part of the real app. |
| Resolve `notes_tracker.txt` / `project_proposal` at repo root | **To Do** | Purpose never confirmed; check whether these should be moved into `docs/`, committed intentionally, or deleted. |
| Missing planning docs (`retrospective.md`) | **To Do** | Need real input from the team, not generated content. `planning.md` and `pairing_log.md` are both done. |
| Rebase `game/configure-board` and reconcile with `game/wire-full-game` | **To Do** | Both branches touch `bin/play.rb`/`game.rb` independently and will need manual reconciliation, plus `Board.new` accepting `win_length`, before the win-length prompt can be wired in for real. |

## Icebox / ideas not yet stories

- Configurable player colors/marks beyond red/yellow.
- Persisting more than win counts (e.g. games played, win streaks) in
  `Scoreboard`.
