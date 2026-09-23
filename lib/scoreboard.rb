# frozen_string_literal: true

require 'json'

# Tracks wins per player name, persisted to a JSON file so counts
# survive between separate runs of the app. Keyed by name rather than
# a fixed player1/player2 slot, since who plays which mark can change
# from session to session.
class ScoreBoard
  DEFAULT_FILE_PATH = File.expand_path('../scoreboard.json', __dir__)

  def initialize(file_path: DEFAULT_FILE_PATH)
    @file_path = file_path
    @wins = load_wins
  end

  # A player with no recorded wins has 0, not an error.
  def wins_for(name)
    @wins[name] || 0
  end

  # Records a win and writes it to disk immediately, so it isn't lost
  # if the app exits right after.
  def record_win(name)
    @wins[name] = wins_for(name) + 1
    save_wins
  end

  def display(names, output: $stdout)
    names.each do |name|
      output.puts "#{name}: #{wins_for(name)} wins"
    end
  end

  private

  def load_wins
    return {} unless File.exist?(@file_path)

    JSON.parse(File.read(@file_path))
  rescue JSON::ParserError
    {}
  end

  def save_wins
    File.write(@file_path, JSON.generate(@wins))
  end
end
