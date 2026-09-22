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
     if @grid[0][column] == " "
      false # returns false if top position of selected column is empty
     else
      true # returns true if the top position contains a piece
     end
   end

  # short way to check if column is full or not
  # def column_full?(column)
  #   board.grid[0][column] != " "
  # end




  # check whether the whole board is full or not
  def full?
    (0...@columns).each do |column| # go thru each column on the board

      # if any part of the board is not filled, then the board can not be full
      if column_full?(column) == false
        return false
      end
    end
    true # if every column is full, then the board is full
  end

  # Checks whether a player has 4 horizontal pieces in a row
  def horizontal_win?(piece)
    @grid.each do |row| # go thru each row on the grid
      (0..@columns - 4).each do |column| # go thru the possible starting positions

        # check the 4 spaces next to each other if they have the same piece eg R
        if row[column] == piece &&
           row[column + 1] == piece &&
           row[column + 2] == piece &&
           row[column + 3] == piece
          return true # 4 consecutive pieces means we have a winner
        end
      end
    end
    false # false if no 4 consecutive pieces
  end


  # Checks for 4 consecutive Vertical pieces
  def vertical_win?(piece)
    (0...@columns).each do |column| # go through each column
      (0..@rows - 4).each do |row| # go thru possible starting rows

        # check if we have 4 spaces below each other
        # vertical changes the row, while keeping the same column
        if @grid[row][column] == piece &&
           @grid[row + 1][column] == piece &&
           @grid[row + 2][column] == piece &&
           @grid[row + 3][column] == piece
          return true # true if we have 4 spaces
        end
      end
    end
    false # if we dont have 4 vertical pieces
  end






end # end class board
