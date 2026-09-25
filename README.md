# Connect N

A terminal-based, two-player Connect Four game with configurable board size and win length — play Connect 4, 5, 6, or beyond.

## Team
- Chibuzo Ufomba ([@cufomba-tamu](https://github.com/cufomba-tamu))
- Michael Zhou ([@Mick1011](https://github.com/Mick1011))

## Project Tracker
[GitHub Project board](https://github.com/users/cufomba-tamu/projects/1) — user stories, point estimates, assignees, and status.


## Description
Two players alternate dropping pieces into a column; each piece falls to
the lowest open row ("gravity"), just like the physical game. First
player to connect the configured number of pieces in a row — horizontal,
vertical, or diagonal — wins. Win counts persist across sessions in a
local scoreboard file.

## Requirements

- Ruby (developed against 4.0.6; see `.ruby-version` if present)
- [Bundler](https://bundler.io/) (`gem install bundler` if you don't have it)

## Setup

```bash
git clone git@github.com-tamu:cufomba-tamu/connect-n.git
cd connect-n
bundle install
```

## Running the game

```bash
ruby bin/play.rb
```

You'll be prompted for:
1. How many pieces in a row wins (3–10, defaults to 4) — board size is
   derived from this automatically
2. Player one's name (defaults to "Red" if left blank)
3. Whether player two is a friend or the computer
4. Player two's name, if playing against a friend

Then it's a normal turn-by-turn game: type a column number to drop a
piece, or `q` to quit at any move prompt. When the game ends in a win
or a draw, results are announced and, on a win, recorded to a local
scoreboard (`scoreboard.json`) that persists across separate runs.

## Running the tests

```bash
bundle exec rspec
```

Runs the full spec suite (`Board`, `Player`, `Game`, and `Scoreboard`
specs). SimpleCov generates a coverage report automatically on each run —
open `coverage/index.html` in a browser afterward to view it.

## Main Features

- Two-player, turn-based gameplay with a gravity drop mechanic — a
  piece falls to the lowest open row in its column
- Win detection in all four directions: horizontal, vertical, and both
  diagonals
- Draw detection when the board fills with no winner
- Input validation: rejects non-numeric input, out-of-range columns,
  and full columns without losing a turn
- Quit mid-game at any move prompt
- Configurable win length (Connect 3 through Connect 10), with board
  size derived automatically from the chosen length
- Optional computer opponent — takes a winning move, otherwise blocks
  the opponent's win, otherwise favors the center column
- Win tracking across sessions via a local scoreboard, keyed by
  player name

## Known Limitations

- The computer opponent only looks one move ahead — it takes an
  immediate win, otherwise blocks an immediate opponent win, otherwise
  favors the center column. It doesn't plan further ahead than that.
- Exactly two players per game (fixed `Red`/`Yellow` marks); no
  support for more players or custom mark colors.
- The scoreboard is a local JSON file (`scoreboard.json`), not shared
  between machines — wins only persist on the device you play on.