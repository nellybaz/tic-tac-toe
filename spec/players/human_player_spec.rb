require_relative '../../lib/tic-tac-toe/players/human_player'
require_relative '../../lib/tic-tac-toe/board'

RSpec.describe HumanPlayer do
  it 'should make a valid move for human player' do
    player = HumanPlayer.new(1, 'X')
    expect(player.symbol).to eq 'X'
    allow(player).to receive(:gets) { '4' }
    board = Board.new(3)
    expect(player.move(board)).to eq 4
  end
end
