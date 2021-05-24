require_relative '../lib/tic-tac-toe/board'

RSpec.describe Board do
  board = nil
  before(:each) do
    board = Board.new(3)
  end

  it 'should set board size' do
    board = Board.new(6)
    expect(board.state.length).to eq 36
  end

  xit 'should set board state' do
    new_state = ['X', 'X', 'X', '.', '.', '.', '.', '.', '.']
    board.state = new_state
    expect(board.state).to eq new_state
    space = board.row_content_space(0)
    expect(board.get_row(0)).to eq "| X#{space}X#{space}X#{space}|"
  end

  it 'should set cell' do
    expect(board.get_cell(0)).to eq '0'
    board.set_cell(0, 'X')
    expect(board.get_cell(0)).to eq 'X'
  end

  it 'should test for moves left' do
    board.state = %w[O O X X X O O X 8]
    expect(board.moves_left?).to eq true

    board.state = %w[O O X X X O O X X]
    expect(board.moves_left?).to eq false
  end

  it 'checks valid move' do
    expect(board.valid_move?('3')).to eq true
  end

  it 'test valid board size' do
    [[3, true], [2, false], ['d', false]].each do |size, resolve|
      expect(Board.valid_baord_size?(size)).to eq resolve
    end
  end
end
