require_relative "lib/board"
require_relative "lib/scoreboard"

board = Board.new(6, 7)

# drop pieces into the board
board.drop_piece(2, "R")
board.drop_piece(2, "B")
board.drop_piece(3, "R")
board.drop_piece(4, "B")

# display the board
board.display_board # displays the board in the terminal

puts "========================================="

# display the player scores in the terminal
scoreboard = ScoreBoard.new(file_path: "tmp_demo_scoreboard.json")

puts "Starting Score:" # Display the starting score
scoreboard.display(["Player 1", "Player 2"])

scoreboard.record_win("Player 1") # give player 1 a win

# display the updated score
puts "\nAfter Player 1 wins:"
scoreboard.display(["Player 1", "Player 2"])

scoreboard.record_win("Player 2") # give player 2 a win

# display the updated score
puts "\nAfter Player 2 wins:"
scoreboard.display(["Player 1", "Player 2"])