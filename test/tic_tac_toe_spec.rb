require_relative '../lib/tic-tac-toe.rb'

RSpec.describe TicTacToe do
  it 'prints correct text' do
    expect(TicTacToe).to receive(:puts).with('Hi there from tic-tac-toe')
    TicTacToe.hi
  end
end