require_relative '../lib/tic-tac-toe.rb'

RSpec.describe TicTacToe do
  it 'prints correct text' do
    expect(TicTacToe).to receive(:puts).with('Hi there from tic-tac-toe')
    TicTacToe.hi
  end

  it 'test valid moves' do
    state = [0,'X',2,'X',4,5,6,7,8]
    expect(TicTacToe.valid_move?(state, 0)).to eq true
    expect(TicTacToe.valid_move?(state, 1)).to eq false
    expect(TicTacToe.valid_move?(state, 3)).to eq false
  end

  it 'test computer moves' do
    state = ['X','X','X','X',4,'X','X','X','X']
    expect(TicTacToe.computer_move(state, 0, 'X')).to eq 4
  end
end