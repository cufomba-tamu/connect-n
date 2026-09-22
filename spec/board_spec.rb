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




end


# test command - bundle exec rspec spec/board_spec.rb
