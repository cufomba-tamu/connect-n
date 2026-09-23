# Design

## System Architecture

The app is split into four small classes plus a terminal entry point.
`Board` and `Player` hold state; `Game` orchestrates turns and I/O;
`Scoreboard` (planned) persists results across sessions.

### `Player` (`lib/player.rb`)

Plain data holder: `name` and `mark` (e.g. `:red`/`:yellow`), both
read-only. `Player` doesn't know about `Board` or `Game` — it's just an
identity.

### `Board` (`lib/board.rb`)

Owns the grid and the rules for placing pieces on it.

- `initialize(rows, columns)` — builds a `rows x columns` grid of empty
  cells (`" "`).
- `drop_piece(column, piece)` — finds the lowest empty cell in a column
  and places `piece` there (gravity). Returns `true`/`false` for
  success.
- `column_full?(column)` — whether a column has room.
- `display_board` — renders the grid to `$stdout`.
- `full?` — whether every column is full (used by `draw?`).
- `horizontal_win?(piece)` / `vertical_win?(piece)` /
  `diagonal_win?(piece)` — check for `piece` connected in each
  direction (diagonal checks both orientations).
- `win?(piece)` — true if `piece` has won in any direction (user story
  #2).
- `draw?(piece1, piece2)` — true if the board is full and neither piece
  has won.

**Known limitation:** the win/draw checks above hardcode a 4-piece
window (`@columns - 4`, `@rows - 4`, and fixed `+1/+2/+3` offset
checks) rather than using a configurable win length. This works for
the default Connect 4 case but will be incorrect once the
win-length-driven board sizing (below) is wired in — e.g. a Connect-5
board would falsely register a win at 4 in a row, and a Connect-3
board would never register a win at all. `Board.new` needs a
`win_length` param (see below) and these three methods need to use it
instead of a literal `4` before user story #2 is genuinely done.

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
(win detection especially) should match this actual behavior.

**Board sizing:** rather than asking for rows, columns, and win length
separately, the player is asked only for win length `N`, and board
size is derived: `columns = 2N - 1`, `rows = N + 2`, with `N`
constrained to `3..10` (rejecting both trivial and impractically large
boards). This keeps setup to a single question and guarantees the
board is always big enough to make an `N`-length win possible without
being unbounded. `Board.new` does not yet accept `win_length` as a
constructor argument — it's computed in `Game#ask_dimensions` but not
yet threaded through to `Board`, which win detection will need.

### `Game` (`lib/game.rb`)

Orchestrates a match: prompts players, validates input, drives the
turn loop, and will hook in win/draw detection and scoreboard
recording.

- `ask_column(player, board, input:, output:)` — prompts one player for
  a move; rejects non-numeric input, out-of-range columns, and full
  columns without advancing the turn; supports quitting via `q`.
- `play(players, board, input:, output:, scoreboard:)` — the turn loop:
  display the board, ask the current player for a column, drop their
  piece, (planned) check for a win or draw, advance to the next
  player. Currently on the `game/wire-full-game` branch, not yet merged
  to `main`.

`input`/`output` are keyword args defaulting to `$stdin`/`$stdout` on
every interactive method, so specs can substitute `StringIO` — this
keeps `Game` testable without mocking global I/O.

### `Scoreboard` (`lib/scoreboard.rb`, planned)

Not yet implemented. Will persist win counts keyed by player `name` to
a file, incremented when `Game#play` detects a win, and read back on
startup so counts survive between runs.

### `bin/play.rb` (planned)

Currently empty. Will be the real entry point: construct `Player`s,
build a `Board` (sized from the chosen win length), load/construct a
`Scoreboard`, and call `Game#play`.

### Interactions

```
bin/play.rb
  → Player.new (x2)
  → Board.new(rows, columns)
  → Scoreboard.new / load
  → Game#play(players, board, scoreboard:)
       → Game#ask_column        (per turn)
       → Board#drop_piece
       → Board#win?             (implemented, hardcoded to 4 — see note above)
       → Board#draw?            (implemented, same caveat)
       → Scoreboard#record_win  (planned, on game end)
```

## User Interface Design

Terminal-only, text-based. A turn looks like:

```
| |X| | | |
| |O|X| | |
|X|O|O|X| |
Alice, choose a column (1-5), or 'q' to quit: 3
```

- Columns are 1-indexed for the player, converted to 0-indexed
  internally.
- The board redraws in full after every move (see user story #6 — not
  yet fully met: `display_board` doesn't currently print column
  numbers above the grid).
- Invalid input (non-numeric, out-of-range, full column) prints a short
  error and re-prompts the same player without consuming their turn
  (user story #3).
- Typing `q` at any move prompt exits immediately with a friendly
  message (user story #7).
- On game end (win/draw), the result is announced and, once
  `Scoreboard` exists, the win is recorded before the app exits.

## Key Design Decisions & Tradeoffs

- **Board size derived from win length, not asked separately** (see
  above) — fewer setup questions, and it structurally prevents
  configuring a board too small to ever produce a win. Tradeoff: the
  player has less control over board shape/aspect ratio.
- **`Player` knows only `name`/`mark`; `Board` only ever operates on
  `mark`.** Keeps `Board` reusable independent of how players are
  represented, and keeps name-based lookups (scoreboard) out of the
  board logic entirely.
- **Dependency-injected `input`/`output` on `Game`.** Chosen specifically
  so specs can drive `Game` with `StringIO` instead of stubbing
  `$stdin`/`$stdout` globally, keeping tests independent and fast.
- **Grid indexed with row `0` at the top (see orientation note above).**
  Not a deliberate choice so much as an artifact of how `drop_piece`
  was written (`downto(0)`) — documented here so it's implemented
  consistently going forward rather than re-litigated per file.
