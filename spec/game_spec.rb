# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/computer_player'
require_relative '../lib/board'
require_relative '../lib/scoreboard'
require 'stringio'
require 'tempfile'

describe Game do
  let(:board) { Board.new(6, 7) }
  let(:player) { Player.new(name: 'Alice', mark: :red) }

  it 'returns a 0-indexed column when input is valid' do
    game = Game.new
    input = StringIO.new("3\n")
    output = StringIO.new

    result = game.ask_column(player, board, input: input, output: output)

    expect(result).to eq(2)
  end

  it 'reprompts on non-numeric input, then accepts a valid one' do
    game = Game.new
    input = StringIO.new("abc\n3\n")
    output = StringIO.new

    result = game.ask_column(player, board, input: input, output: output)

    expect(result).to eq(2)
    expect(output.string).to include('Please enter a number.')
  end

  it 'reprompts on an out-of-range column, then accepts a valid one' do
    game = Game.new
    input = StringIO.new("99\n3\n")
    output = StringIO.new

    result = game.ask_column(player, board, input: input, output: output)

    expect(result).to eq(2)
    expect(output.string).to include('Column must be between 1 and 7.')
  end

  it 'reprompts on a full column, then accepts an open one' do
    small_board = Board.new(1, 2) # 1 row, 2 columns — trivial to fill
    small_board.drop_piece(0, :red) # fills the only cell in column 0

    game = Game.new
    input = StringIO.new("1\n2\n") # first try the full column, then the open one
    output = StringIO.new

    result = game.ask_column(player, small_board, input: input, output: output)

    expect(result).to eq(1) # column 2 (0-indexed as 1)
    expect(output.string).to include('Column 1 is full.')
  end

  it 'exits the program when the player types q' do
    game = Game.new
    input = StringIO.new("q\n")
    output = StringIO.new

    expect {
      game.ask_column(player, board, input: input, output: output)
    }.to raise_error(SystemExit)

    expect(output.string).to include('Thanks for playing!')
  end

  describe '#play' do
    let(:players) do
      [
        Player.new(name: 'Alice', mark: :red),
        Player.new(name: 'Bob', mark: :yellow)
      ]
    end

    it 'ends the game and announces the winner once a player connects 4' do
      game = Game.new
      # Alice drops in columns 1-4 (a horizontal win); Bob drops in column 7
      # each time so his pieces stay out of the way.
      moves = %w[1 7 2 7 3 7 4]
      input = StringIO.new(moves.join("\n") + "\n")
      output = StringIO.new

      game.play(players, board, input: input, output: output)

      expect(output.string).to include('Alice wins!')
    end

    it "announces a draw when the board fills with no winner" do
      game = Game.new
      small_board = Board.new(2, 2) # tiny board, easy to fill without a win

      # Alice and Bob alternate columns so neither gets 2-in-a-row anywhere.
      moves = %w[1 1 2 2]
      input = StringIO.new(moves.join("\n") + "\n")
      output = StringIO.new

      game.play(players, small_board, input: input, output: output)

      expect(output.string).to include("It's a draw!")
    end

    it 'keeps alternating turns when no one has won yet' do
      game = Game.new
      # Alice and Bob each drop once, nowhere near a win; then Alice quits.
      input = StringIO.new("1\n2\nq\n")
      output = StringIO.new

      expect {
        game.play(players, board, input: input, output: output)
      }.to raise_error(SystemExit)

      expect(output.string).to include('Bob, choose a column')
    end

    it 'lets a computer player take its turns without reading input' do
      game = Game.new
      computer_players = [
        Player.new(name: 'Alice', mark: :red),
        ComputerPlayer.new(name: 'Computer', mark: :yellow)
      ]
      # A 2x2 board can never satisfy a 4-in-a-row win, so it always ends
      # in a draw once full — exactly 2 human inputs are needed to fill
      # Alice's turns; the other 2 drops are the computer's, with no
      # input consumed for them.
      tiny_board = Board.new(2, 2)
      input = StringIO.new("1\n2\n")
      output = StringIO.new

      game.play(computer_players, tiny_board, input: input, output: output)

      expect(output.string).to include("It's a draw!")
    end

    it 'records a win to the scoreboard when one is given' do
      game = Game.new
      scoreboard = ScoreBoard.new(file_path: Tempfile.new('scoreboard').path)
      moves = %w[1 7 2 7 3 7 4]
      input = StringIO.new(moves.join("\n") + "\n")
      output = StringIO.new

      game.play(players, board, input: input, output: output, scoreboard: scoreboard)

      expect(scoreboard.wins_for('Alice')).to eq(1)
      expect(output.string).to include('Alice: 1 wins')
    end

    it 'does not touch the scoreboard when none is given' do
      game = Game.new
      moves = %w[1 7 2 7 3 7 4]
      input = StringIO.new(moves.join("\n") + "\n")
      output = StringIO.new

      expect {
        game.play(players, board, input: input, output: output)
      }.not_to raise_error
    end
  end

  describe '#ask_player_name' do
    it 'returns the typed name' do
      game = Game.new
      input = StringIO.new("Alice\n")
      output = StringIO.new

      expect(game.ask_player_name(:red, input: input, output: output)).to eq('Alice')
    end

    it "defaults to the mark's capitalized name on blank input" do
      game = Game.new
      input = StringIO.new("\n")
      output = StringIO.new

      expect(game.ask_player_name(:yellow, input: input, output: output)).to eq('Yellow')
    end
  end
end

describe '#ask_dimensions' do
  it 'returns a derived board size for the default win length' do
    game = Game.new
    input = StringIO.new("\n")
    output = StringIO.new

    result = game.ask_dimensions(input: input, output: output)

    expect(result).to eq([6, 7, 4]) # rows, columns, win_length
  end

  it 'derives board size from a custom win length' do
    game = Game.new
    input = StringIO.new("5\n")
    output = StringIO.new

    result = game.ask_dimensions(input: input, output: output)

    expect(result).to eq([7, 9, 5])
  end

  it 'rejects a win length above the max, then accepts a valid one' do
    game = Game.new
    input = StringIO.new("100000000000\n4\n")
    output = StringIO.new

    result = game.ask_dimensions(input: input, output: output)

    expect(result).to eq([6, 7, 4])
    expect(output.string).to include('Please enter a number between 3 and 10.')
  end

  it 'rejects a win length below the min, then accepts a valid one' do
    game = Game.new
    input = StringIO.new("1\n4\n")
    output = StringIO.new

    result = game.ask_dimensions(input: input, output: output)

    expect(result).to eq([6, 7, 4])
  end
end

describe '#ask_opponent_type' do
  it 'defaults to a human friend on blank input' do
    game = Game.new
    input = StringIO.new("\n")
    output = StringIO.new

    expect(game.ask_opponent_type(input: input, output: output)).to eq(:friend)
  end

  it 'returns :friend when the player types "friend"' do
    game = Game.new
    input = StringIO.new("friend\n")
    output = StringIO.new

    expect(game.ask_opponent_type(input: input, output: output)).to eq(:friend)
  end

  it 'returns :computer when the player types "computer"' do
    game = Game.new
    input = StringIO.new("computer\n")
    output = StringIO.new

    expect(game.ask_opponent_type(input: input, output: output)).to eq(:computer)
  end

  it 'reprompts on an unrecognized answer, then accepts a valid one' do
    game = Game.new
    input = StringIO.new("dog\ncomputer\n")
    output = StringIO.new

    result = game.ask_opponent_type(input: input, output: output)

    expect(result).to eq(:computer)
    expect(output.string).to include("Please type 'friend' or 'computer'.")
  end
end
