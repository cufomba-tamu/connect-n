require_relative "lib/board"

board = Board.new(6, 7)

# drop pieces into the board
board.drop_piece(2, "R")
board.drop_piece(2, "B")
board.drop_piece(3, "R")
board.drop_piece(4, "B")

# display the board
board.display_board # displays the board in the terminal