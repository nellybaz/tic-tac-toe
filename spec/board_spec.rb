require_relative '../lib/tic-tac-toe/board'

RSpec.describe Board do
  [[0, '| 0 1 2 |'], [1, '| 3 4 5 |'], [2, '| 6 7 8 |']].each do |index, resolve|
    it "should get row #{index} of empty game state" do
      Board.new.get_row(index).should == resolve
    end
  end

  it 'should set board state' do
    new_state = ['X', 'X', 'X', '.', '.', '.', '.', '.', '.']
    board = Board.new
    board.state = new_state
    board.state.should == new_state
    board.get_row(0).should == '| X X X |'
  end

  it 'should set cell' do
    board = Board.new
    board.get_cell(0).should == '0'
    board.set_cell(0, 'X')
    board.get_cell(0).should == 'X'
  end

  it 'should be true for winning state in rows' do
    board = Board.new
    new_state = ['X', 'X', 'X', '.', '.', '.', '.', '.', '.']
    board.state = new_state
    board.in_winning_state('X').should == true

    new_state = ['0', '1', '2', 'X', 'X', 'X', '.', '.', '.']
    board.state = new_state
    board.in_winning_state('X').should == true

    new_state = %w[0 1 2 3 4 5 X X X]
    board.state = new_state
    board.in_winning_state('X').should == true
  end

  it 'should be true for winning state in cols' do
    board = Board.new
    new_state = ['X', '.', '.', 'X', '.', '.', 'X', '.', '.']
    board.state = new_state
    board.in_winning_state('X').should == true

    new_state = ['0', 'X', '2', '.', 'X', '.', '.', 'X', '.']
    board.state = new_state
    board.in_winning_state('X').should == true
  end

  it 'should be false for non-winning state in rows' do
    board = Board.new
    new_state = ['X', 'O', 'X', '.', '.', '.', '.', '.', '.']
    board.state = new_state
    board.in_winning_state('X').should == false
  end

  it 'should be false for non-winning state in cols' do
    board = Board.new
    new_state = ['X', 'O', 'X', 'X', '.', '.', '.', '.', '.']
    board.state = new_state
    board.in_winning_state('X').should == false
  end

  it 'should be true for winning state in diagonals' do
    board = Board.new
    new_state = ['X', '.', '.', '.', 'X', '.', '.', '.', 'X']
    board.state = new_state
    board.in_winning_state('X').should == true

    new_state = ['0', '1', 'X', '.', 'X', '.', 'X', '.', '.']
    board.state = new_state
    board.in_winning_state('X').should == true
  end

  it 'should return true for draw state' do
    board = Board.new
    new_state = %w[O O X X X O O X X]
    board.state = new_state
    board.in_draw_state.should == true
  end

  it 'should return false for non-draw state' do
    board = Board.new
    new_state = ['X', '.', '.', '.', 'X', '.', '.', '.', 'X']
    board.state = new_state
    board.in_draw_state.should == false
  end
end
