# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  it 'stores the name' do
    player = Player.new(name: 'Alice', mark: :red)
    expect(player.name).to eq('Alice')
  end

  it 'stores the mark' do
    player = Player.new(name: 'Alice', mark: :red)
    expect(player.mark).to eq(:red)
  end
end