require_relative '../../lib/tic-tac-toe/players/human_player'
require_relative '../../lib/tic-tac-toe/board'

RSpec.describe HumanPlayer do
  let(:player) { HumanPlayer.random1 }

  it 'should make a valid move for human player' do
    expect(player.symbol).to eq 'X'
    allow(player).to receive(:gets) { '4' }
    board = Board.new(3)
    expect(player.move(board)).to eq 4
  end

  it 'should test if human' do
    expect(player.human?).to eq true
  end

  it 'returns correct player key' do
    expect(player.key).to eq 'human'
  end
end
