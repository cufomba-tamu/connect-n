# frozen_string_literal: true
class Board
  attr_accessor :rows, :columns, :grid, :win_length  # we create the getter and setter methods

  def initialize(rows, columns, win_length = 4)

    # Reject win lengths smaller than 3 or larger than 10
    if win_length < 3 || win_length > 10
      raise ArgumentError, "Win length must be between 3 and 10"
    end


    @rows = rows  # board remembers the rows and columns requested... @ means instance variable
    @columns = columns
    @win_length = win_length

    # create an empty game board using the rows & columns
    # use ruby's Array class to create a new array... Array.new(aaa) creates each individual row/column
    @grid = Array.new(rows) { Array.new(columns, " ") } # create 1 row of array with 7 empty spaces/columns
  end                                                   # {} used for a short 1 line block of code. "do" used for longer

  def display_board
    puts column_header
    @grid.each do |row|  # goes through every row in the array
      cells = row.map { |cell| display_cell(cell) }
      puts "|" + cells.join("|") + "|"  # puts vertical bar | between each row/column
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
  # Checks whether a player has enough pieces in a row horizontally
  def horizontal_win?(piece)
    @grid.each do |row| # go thru each row on the board
      count = 0 # count consecutive matching pieces/letters
      row.each do |cell|  # go through each cell in the current row

        if cell == piece # check whether a cell contains a piece
          count += 1  # add 1 to the consecutive count
        else
          count = 0 # the streak was broken, so start counting again
        end
        return true if count >= @win_length  # return true when the required win length is reached
      end
    end
    false # no horizontal winning streak was found
  end


  ####
  # Checks for 4 consecutive Vertical pieces
  # Checks whether a player has enough pieces in a row vertically
  def vertical_win?(piece)
    (0...@columns).each do |column| # go thru each column on the board
      count = 0 # count matching pieces on top of each other
      (0...@rows).each do |row| # go thru each row in the current column

        if @grid[row][column] == piece # check if the cell has the player's piece
          count += 1  # add 1 to the current streak
        else
          count = 0 # the streak is broken, so start over from 0
        end
        return true if count >= @win_length # return true if the required win length is reached
      end
    end
    false # no vertical win was found
  end

  ###########################

  # checks for 4 diagonal pieces from left to right
  # Checks whether a player has enough pieces in a row diagonally
  def diagonal_win?(piece)
    # diagonal win from left to right (downright \)

    (0...@rows).each do |row| # go through each possible starting row
      (0...@columns).each do |column|
        count = 0 # count matching diagonal pieces

        # Start from this position and move to the right side
        while row + count < @rows &&
              column + count < @columns &&
              @grid[row + count][column + count] == piece
          count += 1  # add 1 to the diagonal streak
          return true if count >= @win_length # return true once the required win length is reached
        end
      end
    end

    # diagonal win from right to left (Down left /)

    (0...@rows).each do |row| # go thru each possible starting row
      (0...@columns).each do |column|
        count = 0

        # Start from this position and move to the left
        while row + count < @rows &&
              column - count >= 0 &&
              @grid[row + count][column - count] == piece
          count += 1 # add 1
          return true if count >= @win_length # return true once the required win length is reached
        end
      end
    end
    false # no diagonal win was found
  end

  ##################################
  # check whether a player has won in any direction
  def win?(piece)
    if horizontal_win?(piece) ||
       vertical_win?(piece) ||
       diagonal_win?(piece) # || means OR
      true # one type of win was found
    else
      false # no type of win was found
    end
  end

  # Checks whether the game has ended in a draw
  def draw?(piece1, piece2)

    return false unless full? # it can not be a draw if the board is not full
    return false if win?(piece1) # it can not be a draw if player 1 has won
    return false if win?(piece2) # it can not be a draw if player 2 has won

    true # the board is full and neither player has won
  end

  private

  # A header row of column numbers, aligned above the grid, so players
  # know what to type — e.g. " 1 2 3 4 5 6 7" for a 7-column board.
  def column_header
    ' ' + (1..@columns).map { |number| number.to_s.rjust(cell_width) }.join(' ')
  end

  # Marks display as a single uppercase letter (e.g. :red -> "R")
  # instead of the full word, so rows stay compact and readable. This
  # only changes how a cell is printed — the grid itself still stores
  # the real mark, and win detection is unaffected.
  def display_cell(cell)
    return ' ' * cell_width if cell == ' '

    cell.to_s[0].upcase.rjust(cell_width)
  end

  # Wide enough for the largest column number, e.g. 2 once there are
  # 10+ columns, so the header and cells still line up.
  def cell_width
    @columns.to_s.length
  end

end # end class board
