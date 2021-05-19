require_relative '../../lib/tic-tac-toe/players/player_factory'

RSpec.describe PlayerFactory do
  it 'returns correct player instance' do
    expect(PlayerFactory.make('c', id: 1, symbol: 'X')).to be_instance_of ComputerPlayer
    expect(PlayerFactory.make('s', id: 1, symbol: 'X')).to be_instance_of SmartComputerPlayer
    expect(PlayerFactory.make('h', id: 1, symbol: 'X')).to be_instance_of HumanPlayer
  end
end
