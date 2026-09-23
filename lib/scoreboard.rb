class ScoreBoard
  # lets other classes both players wins
  attr_reader :player1_wins, :player2_wins

  def initialize # create a new scoreboard
    @player1_wins = 0 # starts session with zero wins
    @player2_wins = 0
  end

  def add_player1_win # adds one win to player1
    @player1_wins += 1 # increase player1 wins by one
  end

  def add_player2_win # adds one win to player2
    @player2_wins += 1 # increase player2 wins by one
  end

  # display the current score for both players...
  # use string interpolation, #{@player_x}, simple way to put variable inside a string
  def display
    puts "Player 1: #{@player1_wins} wins" # prints player 1 number of wins
    puts "Player 2: #{@player2_wins} wins"
  end



end # end class

