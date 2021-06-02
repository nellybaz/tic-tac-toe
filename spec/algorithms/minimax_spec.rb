require_relative '../../lib/tic-tac-toe/algorithms/minimax'
require_relative '../../lib/tic-tac-toe/board'

describe Minimax do
  board = Board.new(3)
  it 'should return corerct minimax board evaluation for players' do
    board.state = ['0', '1', 'X', '.', 'X', '.', 'X', '.', '.']
    expect(Minimax.evaluate_board(board)).to eq -10

    board.state = ['0', '1', 'O', '.', 'O', '.', 'O', '.', '.']
    expect(Minimax.evaluate_board(board)).to eq(10)

    board.state = %w[O O X X X O O X X]
    expect(Minimax.evaluate_board(board)).to eq 0
  end
end
