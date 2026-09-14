# Connect N

A terminal-based, two-player Connect Four game with configurable board size and win length — play Connect 4, 5, 6, or beyond.

## Team
- Chibuzo Ufomba ([@cufomba-tamu](https://github.com/cufomba-tamu))
- Michael Zhou 

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

🚧 Not yet available — `Game` and `Board` are still being wired together.
This section will be filled in once `bin/play.rb` is functional.

## Running the tests

```bash
bundle exec rspec
```

Runs the full spec suite (`Board`, `Player`, `Game`, and `Scoreboard`
specs). SimpleCov generates a coverage report automatically on each run —
open `coverage/index.html` in a browser afterward to view it.