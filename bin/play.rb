# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

board = Board.new(6, 7)
# TODO: once Board supports a win_length parameter, prompt for board
# dimensions and win length here instead of hardcoding Connect 4's
# classic 6x7 — this is what "Configure the board" (Issue #4) covers.
players = [
  Player.new(name: 'Player 1', mark: :red),
  Player.new(name: 'Player 2', mark: :yellow)
]

Game.new.play(players, board)