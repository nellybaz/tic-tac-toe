require_relative '../lib/tic-tac-toe/board'

RSpec.describe Board do
  board = nil
  before(:each) do
    board = Board.new(3)
  end

  it 'should get row content space' do
    expect(board.row_content_space(0)).to eq ' ' * 4
    expect(board.row_content_space(11)).to eq ' ' * 3
  end

  it 'should get rows of empty game state' do
    space = board.row_content_space(0)
    [[0, "| 0#{space}1#{space}2#{space}|"], [1, "| 3#{space}4#{space}5#{space}|"]].each do |index, resolve|
      expect(board.get_row(index)).to eq resolve
    end
  end

  it 'should set board size' do
    board = Board.new(6)
    expect(board.state.length).to eq 36
  end

  it 'should draw the board currently' do
    expect(board).to receive(:puts).with(board.horizontal_border)
    (0..board.size - 1).each do |index|
      expect(board).to receive(:puts).with(" #{board.get_row(index)}")
    end
    expect(board).to receive(:puts).with(board.horizontal_border)

    board.draw

    board = Board.new(6)
    expect(board).to receive(:puts).with(board.horizontal_border)
    (0..board.size - 1).each do |index|
      expect(board).to receive(:puts).with(" #{board.get_row(index)}")
    end
    expect(board).to receive(:puts).with(board.horizontal_border)

    board.draw
  end

  it 'should set board state' do
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
    [
      ['X', '.', '.', '.', 'X', '.', '.', '.', 'X'],
      ['0', '1', 'X', '.', 'X', '.', 'X', '.', '.']
    ].each do |new_state|
      board.state = new_state
      expect(board.diagonal_win('X')).to eq true
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
