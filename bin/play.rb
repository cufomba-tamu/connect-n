# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

game = Game.new
rows, columns, win_length = game.ask_dimensions
board = Board.new(rows, columns)

players = [
  Player.new(name: 'Player 1', mark: :red),
  Player.new(name: 'Player 2', mark: :yellow)
]

game.play(players, board)