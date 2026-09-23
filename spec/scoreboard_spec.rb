require_relative "../lib/scoreboard"

describe ScoreBoard do

  # test that both players start with zero wins
  it "starts both players with zero wins" do

    scoreboard = ScoreBoard.new # create a scoreboard
    # player 1 and 2 start with zero wins
    expect(scoreboard.player1_wins).to eq(0)
    expect(scoreboard.player2_wins).to eq(0)
  end

  # test that scoreboard can add a win for player 1
  it "adds a win for player 1" do
    scoreboard = ScoreBoard.new # create a new scoreboard
    scoreboard.add_player1_win # give player1, one win
    expect(scoreboard.player1_wins).to eq(1) # player1 should now have one win
  end

  # test that scoreboard can add a win for player 2
  it "adds a win for player 2" do
    scoreboard = ScoreBoard.new # create a new scoreboard
    scoreboard.add_player2_win # give player2, one win
    expect(scoreboard.player2_wins).to eq(1) # player2 should now have one win
  end

  # test that scoreboard displays both players wins
  it "display both players current wins" do
    scoreboard = ScoreBoard.new # create new scoreboard
    scoreboard.add_player1_win # give one win to player1

    # check what the scoreboard displays
    expect { scoreboard.display }.to output("Player 1: 1 wins\nPlayer 2: 0 wins\n").to_stdout
  end


end # end describe


# test - bundle exec rspec spec/scoreboard_spec.rb