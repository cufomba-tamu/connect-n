# frozen_string_literal: true

require_relative '../lib/computer_player'
require_relative '../lib/board'

describe ComputerPlayer do
  let(:computer) { ComputerPlayer.new(name: 'Computer', mark: :yellow) }

  it 'takes a winning move when one is available' do
    board = Board.new(6, 7)
    # Computer has 3 in a row; column 3 (index 3) completes the win.
    board.drop_piece(0, :yellow)
    board.drop_piece(1, :yellow)
    board.drop_piece(2, :yellow)

    move = computer.choose_move(board, :red)

    expect(move).to eq(3)
  end

  it "blocks the opponent's winning move when the computer has no win of its own" do
    board = Board.new(6, 7)
    # Opponent has 3 in a row; column 3 blocks their win.
    board.drop_piece(0, :red)
    board.drop_piece(1, :red)
    board.drop_piece(2, :red)

    move = computer.choose_move(board, :red)

    expect(move).to eq(3)
  end

  it 'prefers its own winning move over blocking the opponent' do
    board = Board.new(6, 7)
    # Computer can win at column 3; opponent could also win at column 6
    # if not blocked. Winning takes priority over blocking.
    board.drop_piece(0, :yellow)
    board.drop_piece(1, :yellow)
    board.drop_piece(2, :yellow)
    board.drop_piece(4, :red)
    board.drop_piece(5, :red)
    board.drop_piece(6, :red)

    move = computer.choose_move(board, :red)

    expect(move).to eq(3)
  end

  it 'favors the column closest to center when no win or block is available' do
    board = Board.new(6, 7) # empty board, center column is index 3

    move = computer.choose_move(board, :red)

    expect(move).to eq(3)
  end

  it 'never returns a full or out-of-range column' do
    board = Board.new(2, 3) # tiny board
    board.drop_piece(0, :red)
    board.drop_piece(0, :yellow) # column 0 is now full

    move = computer.choose_move(board, :red)

    expect(move).not_to eq(0)
    expect(move).to be_between(0, board.columns - 1)
  end

  it 'leaves the board unchanged after evaluating moves' do
    board = Board.new(6, 7)
    board.drop_piece(0, :yellow)
    board.drop_piece(1, :yellow)
    board.drop_piece(2, :yellow)
    grid_before = board.grid.map(&:dup)

    computer.choose_move(board, :red)

    expect(board.grid).to eq(grid_before)
  end
end
