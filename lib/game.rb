# frozen_string_literal: true

class Game
  def ask_column(player, input: $stdin, output: $stdout)
    output.print "#{player.name}, choose a column, or 'q' to quit: "
    raw = input.gets.strip

    if raw.downcase == 'q'
      output.puts 'Thanks for playing!'
      exit(0)
    end

    raw
  end
end