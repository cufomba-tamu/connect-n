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
      unless column.between?(0, board.columns - 1)
        output.puts "Column must be between 1 and #{board.columns}."
        next
      end

      if board.column_full?(column)
        output.puts "Column #{column + 1} is full."
        next
      end

      return column
    end
  end

  def play(players, board, input: $stdin, output: $stdout, scoreboard: nil)
    current = 0
    loop do
      board.display_board
      player = players[current]
      column = ask_column(player, board, input: input, output: output)
      board.drop_piece(column, player.mark)

      # TODO: check for a win here once Board exposes win detection (Issue #2)
      # TODO: check for a draw here once Board exposes that (Issue #12)
      # TODO: record a win to Scoreboard once it exists (Issue #5)

      current = (current + 1) % players.size
    end
  end
end