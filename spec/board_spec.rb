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

end


# test command - bundle exec rspec spec/board_spec.rb