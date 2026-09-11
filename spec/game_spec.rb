# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require 'stringio'

describe Game do
  it 'returns the typed column when input is not q' do
    game = Game.new
    player = Player.new(name: 'Alice', mark: :red)
    input = StringIO.new("3\n")
    output = StringIO.new

    result = game.ask_column(player, input: input, output: output)

    expect(result).to eq('3')
  end

  it 'exits the program when the player types q' do
    game = Game.new
    player = Player.new(name: 'Alice', mark: :red)
    input = StringIO.new("q\n")
    output = StringIO.new

    expect {
      game.ask_column(player, input: input, output: output)
    }.to raise_error(SystemExit)

    expect(output.string).to include('Thanks for playing!')
  end
end