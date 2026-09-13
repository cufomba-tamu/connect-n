# frozen_string_literal: true

class Game
  def ask_column(player, board, input: $stdin, output: $stdout)
    loop do
      output.print "#{player.name}, choose a column (1-#{board.columns}), or 'q' to quit: "
      raw = input.gets.strip

      if raw.downcase == 'q'
        output.puts 'Thanks for playing!'
        exit(0)
      end

      unless raw.match?(/\A\d+\z/)
        output.puts 'Please enter a number.'
        next
      end

      column = raw.to_i - 1 # players type 1-based, we store 0-based
      return column if column.between?(0, board.columns - 1)

      output.puts "Column must be between 1 and #{board.columns}."
    end
  end
end