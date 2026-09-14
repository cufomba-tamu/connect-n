# frozen_string_literal: true
class Board
  attr_accessor :rows, :columns, :grid  # we create the getter and setter methods

  def initialize(rows, columns)
    @rows = rows  # board remembers the rows and columns requested... @ means instance variable
    @columns = columns

    # create an empty game board using the rows & columns
    # use ruby's Array class to create a new array... Array.new(aaa) creates each individual row/column
    @grid = Array.new(rows) { Array.new(columns, " ") } # create 1 row of array with 7 empty spaces/columns
  end                                                   # {} used for a short 1 line block of code. "do" used for longer

  def display_board
    @grid.each do |row|  # goes through every row in the array
      puts "|" + row.join("|") + "|"  # puts vertical bar | between each row/column
    end
  end

  def drop_piece(column, piece) # drop the piece into the selected column
    (@rows-1).downto(0) do |row| # use down to method for integers... start at the bottom row and move upward

      if @grid[row][column] == " " # check if position is empty
        @grid[row][column] = piece # places the piece onto the selected empty position
        return true
      end
    end
    false # if no empty spaces are found, the column is full
  end

  # check if the column is completely full or not
  def column_full?(column)
    @grid[0][column] != " "
  end


  # def column_full?(column)
  #   if @grid[0][column] == " "
  #     false # returns false if top position of selected column is empty
  #   else
  #     true # returns true if the top position contains a piece
  #   end
  # end


end
