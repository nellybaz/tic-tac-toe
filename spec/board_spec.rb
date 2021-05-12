require_relative '../lib/tic-tac-toe/board'

RSpec.describe Board do
  board = nil
  before(:each) do
    board = Board.new
  end

  [[0, '| 0 1 2 |'], [1, '| 3 4 5 |'], [2, '| 6 7 8 |']].each do |index, resolve|
    it "should get row #{index} of empty game state" do
      expect(board.get_row(index)).to eq resolve
    end
  end

  it 'should set board state' do
    new_state = ['X', 'X', 'X', '.', '.', '.', '.', '.', '.']
    board.state = new_state
    expect(board.state).to eq new_state
    expect(board.get_row(0)).to eq '| X X X |'
  end

  it 'should set cell' do
    expect(board.get_cell(0)).to eq '0'
    board.set_cell(0, 'X')
    expect(board.get_cell(0)).to eq 'X'
  end

  it 'should be true for winning state in rows' do
    [['X', 'X', 'X', '.', '.', '.', '.', '.', '.'],
     ['0', '1', '2', 'X', 'X', 'X', '.', '.', '.'],
     %w[0 1 2 3 4 5 X X X]].each do |new_state|
      board.state = new_state
      expect(board.in_winning_state('X')).to eq true
    end
  end

  it 'should be true for winning state in cols' do
    [['X', '.', '.', 'X', '.', '.', 'X', '.', '.'],
     ['0', 'X', '2', '.', 'X', '.', '.', 'X', '.'],
     %w[0 1 2 3 4 5 X X X]].each do |new_state|
      board.state = new_state
      expect(board.in_winning_state('X')).to eq true
    end
  end

  it 'should be false for non-winning state in rows' do
    new_state = ['X', 'O', 'X', '.', '.', '.', '.', '.', '.']
    board.state = new_state
    expect(board.in_winning_state('X')).to eq false
  end

  it 'should be false for non-winning state in cols' do
    new_state = ['X', 'O', 'X', 'X', '.', '.', '.', '.', '.']
    board.state = new_state
    expect(board.in_winning_state('X')).to eq false
  end

  it 'should be true for winning state in diagonals' do
    [['X', '.', '.', '.', 'X', '.', '.', '.', 'X'],
     ['0', '1', 'X', '.', 'X', '.', 'X', '.', '.'],
     %w[0 1 2 3 4 5 X X X]].each do |new_state|
      board.state = new_state
      expect(board.in_winning_state('X')).to eq true
    end
  end

  it 'should return true for draw state' do
    new_state = %w[O O X X X O O X X]
    board.state = new_state
    expect(board.in_draw_state).to eq true
  end

  it 'should return false for non-draw state' do
    new_state = ['X', '.', '.', '.', 'X', '.', '.', '.', 'X']
    board.state = new_state
    expect(board.in_draw_state).to eq false
  end
end
