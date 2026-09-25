# Design

## System Architecture

The app is split into five small classes plus a terminal entry point.
`Board`, `Player`, and `Scoreboard` hold state; `ComputerPlayer`
extends `Player` with decision-making; `Game` orchestrates turns and
I/O.

### `Player` (`lib/player.rb`)

Plain data holder: `name` and `mark` (e.g. `:red`/`:yellow`), both
read-only. `Player` doesn't know about `Board` or `Game` — it's just an
identity.

### `ComputerPlayer` (`lib/computer_player.rb`)

A `Player` subclass that picks its own move instead of reading input.
`choose_move(board, opponent_mark)` checks, in order:

1. Is there a column where dropping its own mark would win right now?
   Take it.
2. Otherwise, is there a column where the opponent would win if they
   moved there? Take that column to block it.
3. Otherwise, pick whichever open column is closest to the center.

Each candidate move is evaluated by actually calling
`board.drop_piece`, checking `board.win?`, and then undoing the drop
(clearing the topmost occupied cell in that column, since pieces
always fill bottom-up) — so the board is left unchanged by the
evaluation itself. There's no lookahead beyond one move; it satisfies
story #8's acceptance criteria but isn't a real game-playing algorithm.

### `Board` (`lib/board.rb`)

Owns the grid and the rules for placing pieces on it.

- `initialize(rows, columns, win_length = 4)` — builds a `rows x
  columns` grid of empty cells. Raises `ArgumentError` if `win_length`
  is outside `3..10`.
- `drop_piece(column, piece)` — finds the lowest empty cell in a column
  and places `piece` there (gravity). Returns `true`/`false` for
  success.
- `column_full?(column)` / `full?` — whether a column, or the whole
  board, has no room left.
- `display_board` — renders the grid to `$stdout`, with a column-number
  header and marks shown as a single letter (e.g. `:red` → `R`).
- `horizontal_win?(piece)` / `vertical_win?(piece)` /
  `diagonal_win?(piece)` — each checks for `piece` connected
  `win_length` times in that direction, using a running streak count
  that resets on any break. `diagonal_win?` delegates to two private
  helpers, one per diagonal orientation. All three correctly
  generalize to any configured win length, not just 4 — verified by
  hand and by tests at win_length 3, 4, and 10.
- `win?(piece)` — true if `piece` has won in any direction (story #2).
- `draw?(piece1, piece2)` — true if the board is full and neither piece
  has won.

**Grid orientation (as implemented):** the grid is `rows x columns`,
indexed `[row][col]`, but **index `0` is the top of the board, and
index `rows - 1` is the bottom** — the opposite of what earlier project
notes assumed. `drop_piece` searches `(@rows - 1).downto(0)`, so the
first piece dropped into an empty column lands at index `rows - 1`
(the bottom), and later pieces fill upward toward index `0`.
`column_full?` checks `grid[0][column]`, i.e. the top cell. This is
internally consistent — pieces gravity-fall to the visual bottom and
`display_board` (which prints `grid[0]` first, `grid[rows-1]` last)
renders them correctly — but it's worth stating explicitly since it's
easy to assume the opposite. Any new code that touches row indices
should match this actual behavior.

**Board sizing:** rather than asking for rows, columns, and win length
separately, the player is asked only for win length `N` (`Game#ask_dimensions`),
and board size is derived: `columns = 2N - 1`, `rows = N + 2`, with `N`
constrained to `3..10` (rejecting both trivial and impractically large
boards). This keeps setup to a single question and guarantees the
board is always big enough to make an `N`-length win possible.
`win_length` is passed straight through to `Board.new`.

### `Scoreboard` (`lib/scoreboard.rb`)

Tracks wins per player, persisted to a JSON file (`scoreboard.json` by
default, gitignored) so counts survive between separate runs of the
app.

- `initialize(file_path:)` — loads existing wins from the file if it
  exists, otherwise starts empty. The file path is injectable so specs
  never touch the real file.
- `wins_for(name)` — a player with no recorded wins returns `0`, not an
  error.
- `record_win(name)` — increments that player's count and writes the
  file immediately, so a win isn't lost if the app exits right after.
- `display(names, output:)` — prints each given name's current win
  count.

Keyed by player **name** rather than a fixed pair of slots, so it works
regardless of how many games get played or who's assigned which mark.

### `Game` (`lib/game.rb`)

Orchestrates a match: prompts for setup, validates input, drives the
turn loop, and records results.

- `ask_dimensions` / (private) `ask_win_length` — prompts for a win
  length (default 4, range 3–10, re-prompting on invalid input) and
  returns `[rows, columns, win_length]`.
- `ask_opponent_type` — asks "friend or computer," defaulting to
  friend.
- `ask_player_name(mark)` — prompts for a human player's name,
  defaulting to the mark's capitalized name (`Red`/`Yellow`) on blank
  input.
- `ask_column(player, board, input:, output:)` — prompts one player for
  a move; rejects non-numeric input, out-of-range columns, and full
  columns without advancing the turn; supports quitting via `q`.
- `play(players, board, input:, output:, scoreboard:)` — the turn loop:
  display the board, get the current player's move (via
  `ask_column` for a human, `ComputerPlayer#choose_move` for a
  computer — see the private `choose_column` helper), drop the piece,
  then check whether the game just ended (private `game_over?`): a win
  announces the winner, records it to `scoreboard` if one was given,
  and displays updated scores; a draw just announces itself. Either
  ends the loop.

`input`/`output` are keyword args defaulting to `$stdin`/`$stdout` on
every interactive method, so specs can substitute `StringIO` — this
keeps `Game` testable without mocking global I/O.

### `bin/play.rb`

The real entry point. In order: asks for board dimensions, builds a
`Player` for player one (prompting for a name), asks whether player two
is a friend or the computer and builds the corresponding `Player` or
`ComputerPlayer`, constructs a `Scoreboard`, and calls `Game#play`.

### Interactions

```
bin/play.rb
  → Game#ask_dimensions        → Board.new(rows, columns, win_length)
  → Game#ask_player_name (x1-2)
  → Game#ask_opponent_type     → Player.new or ComputerPlayer.new
  → Scoreboard.new
  → Game#play(players, board, scoreboard:)
       → Game#choose_column        (per turn: ask_column or ComputerPlayer#choose_move)
       → Board#drop_piece
       → Game#game_over?
            → Board#win? / Board#draw?
            → Scoreboard#record_win / #display
```

## User Interface Design

Terminal-only, text-based. A turn looks like:

```
 1 2 3 4 5 6 7
| | | | | | | |
| | |Y| | | | |
| |R|R| | | | |
Alice, choose a column (1-7), or 'q' to quit: 3
```

- Columns are 1-indexed for the player, converted to 0-indexed
  internally. The header above the grid shows those same numbers.
- Marks display as a single uppercase letter rather than the full mark
  name, so rows stay compact at any board width (up to 19 columns for
  win_length 10).
- The board redraws in full after every move (story #6).
- Invalid input (non-numeric, out-of-range, full column) prints a short
  error and re-prompts the same player without consuming their turn
  (story #3).
- Typing `q` at any move prompt exits immediately with a friendly
  message (story #7).
- On game end (win/draw), the result is announced; on a win, it's
  recorded to `Scoreboard` and both players' updated totals are shown.

## Key Design Decisions & Tradeoffs

- **Board size derived from win length, not asked separately** — fewer
  setup questions, and it structurally prevents configuring a board too
  small to ever produce a win. Tradeoff: the player has less control
  over board shape/aspect ratio.
- **`Player` knows only `name`/`mark`; `Board` only ever operates on
  `mark`.** Keeps `Board` reusable independent of how players are
  represented, and keeps name-based lookups (scoreboard) out of the
  board logic entirely.
- **Win/draw detection uses a running streak count, not a fixed
  window.** Counting consecutive matches and resetting on a break
  naturally generalizes to any win length, rather than needing separate
  offset math for each possible length.
- **`ComputerPlayer` evaluates moves by actually mutating and then
  undoing the board**, rather than duplicating `Board`'s win-checking
  logic separately for hypothetical states. Keeps the "is this a
  winning move" question answered by the same code path `Game` already
  trusts, at the cost of a drop-then-undo round trip per candidate
  column.
- **`Scoreboard` is keyed by name and persisted to a file**, not a
  fixed pair of in-memory slots, so it reflects who actually played,
  independent of which mark they used or how many sessions have
  happened.
- **Dependency-injected `input`/`output` on `Game`, and an injectable
  file path on `Scoreboard`.** Both exist for the same reason: specs
  can substitute a `StringIO` or a temp file instead of touching real
  global I/O or the real scoreboard file, keeping tests independent and
  fast.
- **Grid indexed with row `0` at the top** (see orientation note
  above). Not a deliberate choice so much as an artifact of how
  `drop_piece` was originally written — documented here so it's
  implemented consistently going forward rather than re-litigated per
  file.
