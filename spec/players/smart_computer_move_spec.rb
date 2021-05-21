require_relative '../../lib/tic-tac-toe/players/smart_computer_player'
require_relative '../../lib/tic-tac-toe/board'

RSpec.describe SmartComputerPlayer do
  let(:player) { SmartComputerPlayer.new(1, 'X') }
  it 'should return best move for smart computer' do
    board = Board.new(3)
    board.state = %w[X O X O O X 6 7 8]
    expect(player.move(board)).to eq 6
  end

  it 'should test if human' do
    expect(player.human?).to eq false
  end
end
