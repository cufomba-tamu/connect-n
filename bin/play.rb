# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/computer_player'
require_relative '../lib/scoreboard'

game = Game.new
rows, columns, win_length = game.ask_dimensions
board = Board.new(rows, columns, win_length)

player_one = Player.new(name: game.ask_player_name(:red), mark: :red)

player_two = if game.ask_opponent_type == :computer
               ComputerPlayer.new(name: 'Computer', mark: :yellow)
             else
               Player.new(name: game.ask_player_name(:yellow), mark: :yellow)
             end

players = [player_one, player_two]
scoreboard = ScoreBoard.new

game.play(players, board, scoreboard: scoreboard)
