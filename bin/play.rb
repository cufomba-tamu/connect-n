# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/computer_player'

game = Game.new
rows, columns, win_length = game.ask_dimensions
board = Board.new(rows, columns, win_length)

player_two = if game.ask_opponent_type == :computer
               ComputerPlayer.new(name: 'Computer', mark: :yellow)
             else
               Player.new(name: 'Player 2', mark: :yellow)
             end

players = [
  Player.new(name: 'Player 1', mark: :red),
  player_two
]

game.play(players, board)
