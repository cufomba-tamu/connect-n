# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'
require 'stringio'

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
  end
end