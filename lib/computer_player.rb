# frozen_string_literal: true

require_relative 'player'

# A non-interactive Player that picks its own move each turn:
# take a winning move if one exists, otherwise block the opponent's
# immediate winning move, otherwise favor the column closest to center.
class ComputerPlayer < Player
  def choose_move(board, opponent_mark)
    available_columns = (0...board.columns).reject { |column| board.column_full?(column) }

    winning_column = available_columns.find { |column| winning_move?(board, column, mark) }
    return winning_column if winning_column

    blocking_column = available_columns.find { |column| winning_move?(board, column, opponent_mark) }
    return blocking_column if blocking_column

    closest_to_center(available_columns, board.columns)
  end

  private

  # Drops a piece to see whether it would win, then undoes the drop so
  # the board is left exactly as it was before the check.
  def winning_move?(board, column, piece)
    return false unless board.drop_piece(column, piece)

    wins = board.win?(piece)
    undo_drop(board, column)
    wins
  end

  # The most recently dropped piece in a column is always the topmost
  # occupied cell, since pieces fill from the bottom up — so clearing
  # the first non-empty cell (scanning from index 0) undoes the last drop.
  def undo_drop(board, column)
    board.grid.each do |row|
      next if row[column] == ' '

      row[column] = ' '
      break
    end
  end

  def closest_to_center(columns, board_width)
    center = (board_width - 1) / 2.0
    columns.min_by { |column| (column - center).abs }
  end
end
