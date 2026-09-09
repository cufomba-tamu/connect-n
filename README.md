# Connect N

A terminal-based, two-player Connect Four game with configurable board size and win length — play Connect 4, 5, 6, or beyond.

## Team
- Chibuzo Ufomba ([@cufomba-tamu](https://github.com/cufomba-tamu))
- Michael Zhou 

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