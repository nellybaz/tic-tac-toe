require_relative '../lib/tic-tac-toe/move_validator'
require_relative '../lib/tic-tac-toe/board'

RSpec.describe MoveValidator do
  it 'checks valid move' do
    board = Board.new(3)
    expect(MoveValidator.valid_move?(board, 3)).to eq true
    expect(MoveValidator.valid_move?(board, 10)).to eq false
  end
end
