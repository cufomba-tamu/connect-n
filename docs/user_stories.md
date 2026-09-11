# User Stories

## 1. Drop a piece (essential) — 3 points

**As a** player, **I want to** drop a piece into a column **so that** I
can take my turn.

**Acceptance criteria:**
- The piece lands in the lowest currently-empty row of the chosen column.
- Dropping into a column that's already full is rejected, not silently
  ignored or crashed.
- The board is re-rendered after every successful move so the state is
  always visible.

---

## 2. Detect a win (essential) — 5 points

**As a** player, **I want to** have the game detect when I've connected N
pieces in a row **so that** the game correctly and immediately declares a
winner.

**Acceptance criteria:**
- Detects a win horizontally, vertically, and on both diagonals.
- Works for any configured win length, not just 4.
- The game ends immediately when a win is detected.

---

## 3. Reject invalid move input (essential, sad path) — 2 points

**As a** player, **I want to** be told clearly when my input is invalid
**so that** I don't lose my turn, corrupt the game state, or crash the
app by mistyping.

**Acceptance criteria:**
- Non-numeric input (e.g. "abc") shows an error and re-prompts the same
  player without advancing the turn.
- An out-of-range column number (e.g. 0, or higher than the board width)
  shows an error and re-prompts.
- A full column is rejected with a clear message and re-prompts.
- The game never crashes on bad input.

---

## 4. Configure the board (essential) — 3 points

**As a** pair of players, **we want to** choose the board size and win
length before the game starts **so that** we can play Connect 4, Connect
5, Connect 6, or any other variant we like.

**Acceptance criteria:**
- Prompted for columns, rows, and win length at the start of a game, with
  sensible defaults (7×6, win length 4) if the player just presses Enter.
- A configuration where the win length can't fit anywhere on the board
  (e.g. a 3×3 board with win length 4) is rejected with a specific error
  message, and the player is asked again rather than the game crashing or
  silently proceeding.

---

## 5. Track wins across sessions — 2 points

**As a** competitive player, **I want to** have my wins tracked across
multiple play sessions **so that** my friend and I can see who's ahead
over time, not just within a single game.

**Acceptance criteria:**
- Each player is prompted for a name before play begins; a blank entry
  falls back to a sensible default (e.g. their mark, "Red"/"Yellow").
- A win is recorded to a persistent scoreboard file immediately when the
  game ends.
- Closing and reopening the app preserves previous win counts.
- A player with no recorded wins shows a count of zero rather than an
  error.

---

## 6. See the board clearly — 1 point

**As a** player, **I want to** see the board rendered clearly in the
terminal after every move **so that** I can track the current game state
without confusion.

**Acceptance criteria:**
- Empty cells, and each player's pieces, are visually distinct.
- Columns are labeled with numbers so players know what to type.
- The board is re-drawn after every move, not just at the start.

---

## 7. Quit mid-game — 1 point

**As a** player, **I want to** be able to quit in the middle of a game
**so that** I'm not forced to finish a match I no longer have time for.

**Acceptance criteria:**
- Typing a quit command (e.g. "q") at any move prompt exits the app
  gracefully with a friendly message.
- No partial or corrupted state is written to the scoreboard file when
  quitting mid-game.

---

## 8. Play against the computer (stretch) — 5 points

**As a** solo player, **I want to** play against a computer opponent
**so that** I can play even when a second person isn't available.

**Acceptance criteria:**
- The computer takes a winning move if one is available.
- Otherwise, the computer blocks an opponent's immediate winning move if
  one exists.
- Otherwise, the computer favors columns closer to the center.
- The computer never makes an invalid move (full/out-of-range column).

---

## 9. Set up player identity — 1 point

**As a** player, **I want to** be represented by a name and a distinct
mark (piece) **so that** the game and scoreboard can tell players apart.

**Acceptance criteria:**
- Each player has a name and a mark (e.g. `:red` or `:yellow`).
- A player's mark is what gets placed on the board and checked for wins.
- A player's name is what gets used to record and look up scoreboard wins.