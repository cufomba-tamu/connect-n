# frozen_string_literal: true

require_relative "../lib/board"

describe Board do  # testing the Board class using rspec
  it "stores the number of rows" do
    board = Board.new(6, 7) # we create a Board object with 6 rolls and 7 columns
    expect(board.rows).to eq(6) # expect number of rows to equal 6
  end

  it "stores the number of columns" do
    board = Board.new(6, 7)
    expect(board.columns).to eq(7)
  end

  it "creates a grid with the correct number of rows" do
    board = Board.new(6, 7)
    expect(board.grid.length).to eq(6) # should contain 6 rows
  end

  it "creates a grid with the correct number of columns" do
    board = Board.new(6, 7)
    expect(board.grid[0].length).to eq(7) # to check the number rows starting from index [0]
                                          # length checks the amount of columns in that row
  end

  it "displays the board" do
    board = Board.new(2, 3)  # creates a 2x3 board.. its simpler to test this case than a bigger 6x7 board

    # runs the board display and checks what is printed to the terminal
    expect {board.display_board}.to output("| | | |\n| | | |\n").to_stdout # to std_out means we expect
                                                                          # this outcome to be printed to the terminal
  end

end


# test command - bundle exec rspec spec/board_spec.rb