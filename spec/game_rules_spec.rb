require_relative '../lib/tic-tac-toe/game_rules'
require_relative '../lib/tic-tac-toe/board'

RSpec.describe GameRules do
  describe 'Columns' do
    it 'should be true for winning state in cols' do
      board = Board.new(3)
      [['X', '.', '.', 'X', '.', '.', 'X', '.', '.'],
       ['0', 'X', '2', '.', 'X', '.', '.', 'X', '.'],
       %w[0 1 X 3 4 X 6 7 X]].each do |new_state|
        board.state = new_state
        expect(GameRules.column_win?(board, 'X')).to eq true
        expect(GameRules.win?(board, 'X')).to eq true
      end
    end
  end

  describe 'Rows' do
    board = Board.new(3)
    it 'should be true for winning state in rows' do
      [['X', 'X', 'X', '.', '.', '.', '.', '.', '.'],
       ['0', '1', '2', 'X', 'X', 'X', '.', '.', '.'],
       %w[0 1 2 3 4 5 X X X]].each do |new_state|
        board.state = new_state
        expect(GameRules.row_win?(board, 'X')).to eq true
      end
    end

    it 'should be false for non-winning state in rows' do
      new_state = ['X', 'O', 'X', '.', '.', '.', '.', '.', '.']
      board.state = new_state
      expect(GameRules.row_win?(board, 'X')).to eq false
    end
  end

  describe 'Diagonals' do
    board = Board.new(3)
    it 'should be true for winning state in diagonals' do
      [
        ['X', '.', '.', '.', 'X', '.', '.', '.', 'X'],
        ['0', '1', 'X', '.', 'X', '.', 'X', '.', '.']
      ].each do |new_state|
        board.state = new_state
        expect(GameRules.diagonal_win?(board, 'X')).to eq true
        expect(GameRules.diagonal_win?(board, 'X')).to eq true
      end
    end
  end

  it 'wins for any winning state' do
    board = Board.new(3)
    [['X', '.', '.', 'X', '.', '.', 'X', '.', '.'],
     ['0', 'X', '2', '.', 'X', '.', '.', 'X', '.'],
     %w[0 1 X 3 4 X 6 7 X]].each do |new_state|
      board.state = new_state
      expect(GameRules.win?(board, 'X')).to eq true
    end
  end

  describe 'Drwas' do
    board = Board.new(3)
    it 'should return true for draw state' do
      new_state = %w[O O X X X O O X X]
      board.state = new_state
      expect(GameRules.draw?(board)).to eq true
    end

    it 'should return false for non-draw state' do
      new_state = ['X', '.', '.', '.', 'X', '.', '.', '.', 'X']
      board.state = new_state
      expect(GameRules.draw?(board)).to eq false
    end
  end
end
