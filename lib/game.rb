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

      if board.win?(player.mark)
        board.display_board
        output.puts "#{player.name} wins!"
        # TODO: record a win to Scoreboard once it exists (Issue #5)
        return
      end

      if board.draw?(players[0].mark, players[1].mark)
        board.display_board
        output.puts "It's a draw!"
        return
      end

      current = (current + 1) % players.size
    end
  end

  def ask_dimensions(input: $stdin, output: $stdout)
    output.puts 'Configure your board — how many pieces in a row wins?'
    win_length = ask_win_length(input: input, output: output)
    columns = (2 * win_length) - 1
    rows = win_length + 2
    [rows, columns, win_length]
  end

  private

  def ask_win_length(input:, output:, default: 4, min: 3, max: 10)
    loop do
      output.print "Connect how many in a row? [#{default}]: "
      raw = input.gets.strip
      return default if raw.empty?

      begin
        win_length = Integer(raw)
      rescue ArgumentError
        output.puts 'Please enter a whole number.'
        next
      end

      return win_length if win_length.between?(min, max)

      output.puts "Please enter a number between #{min} and #{max}."
    end
  end
end
