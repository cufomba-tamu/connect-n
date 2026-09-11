# frozen_string_literal: true
class Board
  attr_accessor :rows, :columns, :grid  # we create the getter and setter methods

  def initialize(rows, columns)
    @rows = rows  # board remembers the rows and columns requested
    @columns = columns

    # create an empty game board using the rows & columns
    # use the ruby's Array class to create a new array... Array.new(aaa) creates each individual row
    @grid = Array.new(rows) { Array.new(columns, " ") } # create 1 row of array with 7 empty spaces/columns
  end

  def display_board
    @grid.each do |row|  # goes through every row
      puts "|" + row.join("|") + "|"  # puts | between each row/column
    end
  end

end

board = Board.new(6, 7)
board.display_board