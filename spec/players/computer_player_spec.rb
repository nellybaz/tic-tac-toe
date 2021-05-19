require_relative '../../lib/tic-tac-toe/players/computer_player'
require_relative '../../lib/tic-tac-toe/board'

RSpec.describe ComputerPlayer do
  it 'should return 4 as computer move' do
    player = ComputerPlayer.new(1, 'X')

    expect(player).to receive(:puts).with('🤖 Computer played 4 🤖')
    board = Board.new(3)
    board.state = %w[X X X X 4 X X X X]
    expect(player.move(board)).to eq 4
  end
end

