# frozen_string_literal: true

require_relative "../lib/board"

describe Board do  # testing the Board class using rspec
  it "stores the number of rows" do
    board = Board.new(6, 7) # we create a Board object with 6 rows and 7 columns
    expect(board.rows).to eq(6) # expect number of rows to equal 6
  end

  it "stores the number of columns" do
    board = Board.new(6, 7)
    expect(board.columns).to eq(7)
  end

  # test for creating the specifies board
  it "creates a grid with the correct number of rows" do
    board = Board.new(6, 7)
    expect(board.grid.length).to eq(6) # should contain 6 rows
  end

  it "creates a grid with the correct number of columns" do
    board = Board.new(6, 7)
    expect(board.grid[0].length).to eq(7) # to check the number rows starting from index [0]
                                          # length checks the amount of columns in that row
  end

  #####
  # test for displaying the board.. we should see it in the terminal
  it "displays the board" do
    board = Board.new(2, 3)  # creates a 2x3 board.. its simpler to test this case than a bigger 6x7 board

    # runs the board display and checks what is printed to the terminal
    expect {board.display_board}.to output("| | | |\n| | | |\n").to_stdout # to std_out means we expect
                                                                          # this outcome to be printed to the terminal
  end

  # note that when we have 6 rows, we have indexes 0 to 5.. top row 1 is index 0.. bottom row 6 is index 5
  #  row1  --> index 0
  #  row2  --> index 1
  # the same applies to columns, we count from index 0

  # test for dropping piece into the bottom of the column
  it "drops a piece into the bottom of the grid/column" do
    board = Board.new(6, 7)
    board.drop_piece(2, "R") # drops R into index 2 (3rd column)
    expect(board.grid[5][2]).to eq("R")
  end

  # test case for stacking pieces on top of each other
  it "stacks the pieces in the same column" do
    board = Board.new(6, 7)
    board.drop_piece(2, "R") # R fore Red
    board.drop_piece(2, "B") # B for blue.. drops our piece into the same column
    expect(board.grid[5][2]).to eq("R") # R at the bottom
    expect(board.grid[4][2]).to eq("B") # B is directly above R
  end

  # test for rejecting a move when the column is full
  it "does not place a piece when the column is full" do
    board = Board.new(2, 3)
    board.drop_piece(1, "R") # fill column index 1
    board.drop_piece(1, "B")

    result = board.drop_piece(1, "R") # try to drop another piece when the board is full
    expect(result).to eq(false) # the move should fail
  end

  # test for detecting when a column is full
  it "detect when a column is full" do
    board = Board.new(2, 3)

    board.drop_piece(1, "R") # fill column index 1
    board.drop_piece(1, "B")

    expect(board.column_full?(1)).to eq(true)
  end

  # test for detecting when a column still has space
  it "detect when a column is not full" do
    board = Board.new(2, 3) # create a small board
    board.drop_piece(1, "R") # add one piece only so we know there is still space

    expect(board.column_full?(1)).to eq(false) # expect the column to not be full

  end

  # test fo detecting when a board is full
  it "detects when the board is full" do

    board = Board.new(2, 2) # create a small 2x2 board

    board.drop_piece(0, "R") # fill the first column
    board.drop_piece(0, "B")

    board.drop_piece(1, "B") # fill the second column
    board.drop_piece(1, "R")

    expect(board.full?).to eq(true)
  end

  # test that the board knows when it still has empty spaces
  it "detects when the board is not full" do

    board = Board.new(2, 2)

    board.drop_piece(0, "R") # add only 1 piece

    expect(board.full?).to eq(false)
  end

  # Test win detections.. new
  # Test that the board accepts a win length of 3
  it "accepts a win length of 3" do
    board = Board.new(6, 7, 3) # create a board where 3 pieces are needed to win
    expect(board.win_length).to eq(3) # check that the win length was stored
  end

  # Test that the board accepts the default win length of 4
  it "uses 4 as the default win length" do
    board = Board.new(6, 7) # create a board without giving a win length
    expect(board.win_length).to eq(4) # default win length is 4
  end

  # Test that the board accepts a win length of 10
  it "accepts a win length of 10" do
    board = Board.new(10, 10, 10) # 10 pieces are needed to win
    expect(board.win_length).to eq(10) # check win lenghth of 10
  end

  # Test that a win length below 3 is rejected
  it "rejects a win length below 3" do
    expect { Board.new(6, 7, 2) }.to raise_error(ArgumentError)
  end

  # Test that a win length above 10 is rejected
  it "rejects a win length above 10" do
    expect { Board.new(15, 15, 11) }.to raise_error(ArgumentError)
  end

  ##### 3 in a row is a win
  # Test that 3 pieces in a row is a win when win length is 3
  it "detects a horizontal win with 3 pieces when win length is 3" do
    board = Board.new(6, 7, 3)

    board.drop_piece(0, "R")
    board.drop_piece(1, "R")
    board.drop_piece(2, "R")

    expect(board.horizontal_win?("R")).to eq(true)
  end

  # Test that 10 pieces in a row is a win when win length is 10
  it "detects a horizontal win with 10 pieces when win length is 10" do
    board = Board.new(10, 15, 10)

    # Drop 10 matching pieces across the bottom row
    (0..9).each do |column|
      board.drop_piece(column, "R")
    end

    expect(board.horizontal_win?("R")).to eq(true)
  end

  # test for the board to detect a horizontal win
  it "detects when a horizontal win occurs" do
    board = Board.new(6, 7) # standard board size

    #place 4 "R" pieces next to each other
    board.drop_piece(0, "R")
    board.drop_piece(1, "R")
    board.drop_piece(2, "R")
    board.drop_piece(3, "R")

    # R should win if we have 4 consecutive pieces
    expect(board.horizontal_win?("R")).to eq(true)
  end

  # test 3 pieces in a row is not a win
  it "it does not detect a win when we have only 3 pieces" do
    board = Board.new(6, 7)

    board.drop_piece(0, "R") # only 3 pieces next to each other
    board.drop_piece(1, "R")
    board.drop_piece(2, "R")

    expect(board.horizontal_win?("R")).to eq(false) # 3 pieces is not a win, equals to false
  end

  # test to detect a vertical win
  it "detects a vertical win" do
    board = Board.new(6, 7) # 6x7 board

    board.drop_piece(2, "R") # drop 4 pieces vertically in the same column
    board.drop_piece(2, "R")
    board.drop_piece(2, "R")
    board.drop_piece(2, "R")

    expect(board.vertical_win?"R").to eq(true) # 4 Rs should win
  end

  # test that 3 vertical pieces in a row are not a win
  it "it does not detect 2 pieces in a row as a win" do
    board = Board.new(6, 7) # board

    board.drop_piece(2, "R") # drop 3 pieces only in the same column
    board.drop_piece(2, "R")
    board.drop_piece(2, "R")

    expect(board.vertical_win?("R")).to eq(false) # 3 pieces is not a win
  end
  ####
  # Test that 3 pieces vertically is a win when win length is 3
  it "detects a vertical win with 3 pieces when win length is 3" do
    board = Board.new(6, 7, 3)

    board.drop_piece(2, "R")
    board.drop_piece(2, "R")
    board.drop_piece(2, "R")

    expect(board.vertical_win?("R")).to eq(true)
  end

  # Test that 10 pieces vertically is a win when win length is 10
  it "detects a vertical win with 10 pieces when win length is 10" do
    board = Board.new(10, 15, 10)

    # Drop 10 matching pieces into the same column
    10.times do
      board.drop_piece(3, "R")
    end
    expect(board.vertical_win?("R")).to eq(true)
  end


  ####
  # test diagonal win going left to the right side (\)
  it "detects a diagonal win a diagonal win going down right" do
    board = Board.new(6, 7)

    # manually place the pieces to create the diagonal win \... since we are not dropping anymore
    board.grid[2][0] = "R"
    board.grid[3][1] = "R"
    board.grid[4][2] = "R"
    board.grid[5][3] = "R"

    expect(board.diagonal_win?("R")).to eq(true) # 4 diagonal pieces is a win
  end

  # test diagonal win going down from right to left side (/)
  it "detect a diagonal win a diagonal win going down to left side" do
    board = Board.new(6, 7)

    # manually place the pieces. diagonal win from right to left
    board.grid[2][3] = "R"
    board.grid[3][2] = "R"
    board.grid[4][1] = "R"
    board.grid[5][0] = "R"

    expect(board.diagonal_win?("R")).to eq(true) # true is we have 4 consecutive pieces diagonally
  end


  # test that 3 diagonal pieces are not enough to win
  it "does not detect a diagonal win if we have 3 pieces only" do
  board = Board.new(6, 7)

  board.grid[3][0] = "R"
  board.grid[4][1] = "R"
  board.grid[5][2] = "R"

  expect(board.diagonal_win?("R")).to eq(false)
  end
  #######
  # Test that 3 diagonal pieces is a win when win length is 3.. left to right(\)
  it "detects a diagonal win with 3 pieces when win length is 3" do
    board = Board.new(6, 7, 3)

    board.grid[2][0] = "R"
    board.grid[3][1] = "R"
    board.grid[4][2] = "R"

    expect(board.diagonal_win?("R")).to eq(true)
  end


  # Test that 10 diagonal pieces is a win when win length is 10.. left to right (\)
  it "detects a diagonal win with 10 pieces when win length is 10" do
    board = Board.new(15, 15, 10)

    # create a left to right diagonal of 10 pieces (\)
    (0...10).each do |position| # go thru numbers 0 to 9, and
      board.grid[position][position] = "R" # use each number as both row index and the column index
    end
    expect(board.diagonal_win?("R")).to eq(true)
  end
  #####
  # Test that win? detects a Connect 3 win
  it "detects a win when win length is 3" do
    board = Board.new(6, 7, 3)

    board.drop_piece(0, "R")
    board.drop_piece(1, "R")
    board.drop_piece(2, "R")

    expect(board.win?("R")).to eq(true)
  end

  # Test that win? detects a Connect 10 win
  it "detects a win when win length is 10" do
    board = Board.new(15, 15, 10)

    # Create 10 matching pieces horizontally
    (0...10).each do |column|
      board.drop_piece(column, "R")
    end
    expect(board.win?("R")).to eq(true)
  end




  #######

  # test to check a win in any direction
  it "detects a win in any direction" do
    board = Board.new(6, 7)

    board.drop_piece(0, "R") # 4 Rs horizontally
    board.drop_piece(1, "R")
    board.drop_piece(2, "R")
    board.drop_piece(3, "R")

    expect(board.win?("R")).to eq(true) # win method should detect R has won
  end

  # test to return false when no one has won
  it "detects when a player has not won" do
    board = Board.new(6, 7)

    board.drop_piece(0, "R") # place only 3 Rs
    board.drop_piece(1, "R")
    board.drop_piece(2, "R")

    expect(board.win?("R")).to eq(false) # 3 Rs not enough for a win
  end

  # Test to detect a draw
  it "detects a draw when the board is full and no player has won" do
    board = Board.new(2, 3) # 2x3 board

    board.drop_piece(0, "R") # fill column 0
    board.drop_piece(0, "B")

    board.drop_piece(1, "B") # fill column 1
    board.drop_piece(1, "R")

    board.drop_piece(2, "R") # fill column 2
    board.drop_piece(2, "B")

    # the board is full and nobody has won
    expect(board.draw?("R", "B")).to eq(true) #
  end

  # test that an unfinished game is not a draw
  it "does not detect a draw when the board is not full" do
    board = Board.new(6, 7) # standard board

    # we add a few pieces, since we are detecting an unfinished game
    board.drop_piece(0, "R")
    board.drop_piece(1, "R")

    # there are still empty spaces, its not a draw
    expect(board.draw?("R", "B")).to eq(false)
  end
  #####
  # Test that a full board is not a draw if someone wins
  it "does not detect a draw when a player has won with win length 3" do
    board = Board.new(3, 3, 3)

    # Fill the board
    board.grid[0] = ["R", "B", "B"]
    board.grid[1] = ["R", "B", "R"]
    board.grid[2] = ["R", "R", "B"]

    # Player R has 3 vertically in column 0
    expect(board.draw?("R", "B")).to eq(false)
  end

  ####


end # end describe


# test - bundle exec rspec spec/board_spec.rb
