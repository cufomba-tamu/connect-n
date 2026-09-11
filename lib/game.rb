# frozen_string_literal: true

class Game
  def ask_column(player)
    print "#{player.name}, choose a column, or 'q' to quit: "
    raw = gets.strip

    if raw.downcase == 'q'
      puts 'Thanks for playing!'
      exit(0)
    end

    raw
  end
end
