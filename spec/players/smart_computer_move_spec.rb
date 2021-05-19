require_relative '../../lib/tic-tac-toe/players/smart_computer_player'
require_relative '../../lib/tic-tac-toe/board'

RSpec.describe SmartComputerPlayer do
  it 'should return best move for smart computer' do
    player = SmartComputerPlayer.new(1, 'X')
    board = Board.new(3)
    board.state = %w[X O X O O X 6 7 8]
    expect(player.move(board)).to eq 8
  end
end
