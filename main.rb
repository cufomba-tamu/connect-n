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

#############################################

# display the player scores in the terminal
scoreboard = ScoreBoard.new

puts "Starting Score:" # Display the starting score
scoreboard.display

scoreboard.add_player1_win # give player 1 a win

# display the updated score
puts "\nAfter Player 1 wins:"
scoreboard.display

scoreboard.add_player2_win # give player 2 a win

# display the updated score
puts "\nAfter Player 2 wins:"
scoreboard.display