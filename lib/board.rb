# frozen_string_literal: true
class Board
  attr_accessor :rows, :columns  # we create the getter and setter methods

  def initialize(rows, columns)
    @rows = rows  # board remembers the rows and columns requested
    @columns = columns
  end
end
