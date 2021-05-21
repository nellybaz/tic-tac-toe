require_relative '../../lib/tic-tac-toe/players/computer_player'
require_relative '../../lib/tic-tac-toe/board'

RSpec.describe ComputerPlayer do
  let(:player) { ComputerPlayer.new(1, 'X') }
  it 'should return 4 as computer move' do
    expect(player).to receive(:puts).with('🤖 Computer played 4 🤖')
    board = Board.new(3)
    board.state = %w[X X X X 4 X X X X]
    expect(player.move(board)).to eq 4
  end

  it 'should test if human' do
    expect(player.human?).to eq false
  end

  it 'returns correct player key' do
    expect(player.key).to eq 'computer'
  end
end
