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

🚧 Not yet available on `main` — `bin/play.rb` is still empty here. The
turn loop, win/draw detection, and board-configuration prompt exist on
separate feature branches (`game/wire-full-game`,
`game/configure-board`) that haven't been merged in yet. See Known
Limitations below and the Project board for current status.

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
- Win tracking across sessions via a local scoreboard

## Known Limitations

- The game isn't playable end-to-end from `main` yet — `bin/play.rb`
  is empty; the turn loop and win-length prompt exist on unmerged
  feature branches.
- Win/draw detection currently only works correctly for the default
  4-in-a-row case. Generalizing it to any configured win length
  (3–10) is in progress.
- The scoreboard is in-memory only right now — it doesn't yet persist
  wins across separate runs of the app, and isn't keyed by player
  name.
- The board display doesn't yet label columns with numbers.