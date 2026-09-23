# frozen_string_literal: true

require_relative '../lib/scoreboard'
require 'tempfile'

describe ScoreBoard do
  # Each example gets its own temp file so tests never touch the real
  # scoreboard.json or leak state into each other.
  let(:file_path) { Tempfile.new('scoreboard').path }
  let(:scoreboard) { ScoreBoard.new(file_path: file_path) }

  it 'shows zero wins for a player with no recorded wins' do
    expect(scoreboard.wins_for('Alice')).to eq(0)
  end

  it 'records a win for a player by name' do
    scoreboard.record_win('Alice')

    expect(scoreboard.wins_for('Alice')).to eq(1)
  end

  it "keeps each player's wins separate" do
    scoreboard.record_win('Alice')
    scoreboard.record_win('Alice')
    scoreboard.record_win('Bob')

    expect(scoreboard.wins_for('Alice')).to eq(2)
    expect(scoreboard.wins_for('Bob')).to eq(1)
  end

  it 'persists wins across separate instances (closing and reopening the app)' do
    scoreboard.record_win('Alice')

    reloaded = ScoreBoard.new(file_path: file_path)

    expect(reloaded.wins_for('Alice')).to eq(1)
  end

  it "displays each given player's current wins, including zero" do
    scoreboard.record_win('Alice')

    expect { scoreboard.display(%w[Alice Bob]) }
      .to output("Alice: 1 wins\nBob: 0 wins\n").to_stdout
  end

  it "starts fresh with no wins when the file doesn't exist yet" do
    missing_path = "#{file_path}-does-not-exist"

    fresh_scoreboard = ScoreBoard.new(file_path: missing_path)

    expect(fresh_scoreboard.wins_for('Alice')).to eq(0)
  end
end
