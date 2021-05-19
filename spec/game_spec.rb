require 'rspec'
require_relative '../lib/tic-tac-toe/game'
require_relative '../lib/tic-tac-toe/players/human_player'
require_relative '../lib/tic-tac-toe/players/player_factory'

RSpec.describe Game do
  let(:game) { Game.new }
  before(:each) do
    expect($stdout).to receive(:puts).with('Welcome to Tic-Tac-Toe')
    # game = Game.new
  end

  it 'should switch player' do
    [1, 2, 1].each do |player|
      expect(game.current_player.id).to eq player
      game.next_player
    end
  end

  it 'should return right symbol for right player' do
    %w[X O].each do |symbol|
      expect(game.current_symbol).to eq symbol
      game.next_player
    end
  end

  it 'should set computer as current player if human is not playing first' do
    game = Game.new(PlayerFactory.make(key: 'h', id: 1, symbol: 'X'),
                    PlayerFactory.make(key: 'c', id: 2,
                                       symbol: 'O'),
                    Board.new(3))

    expect(game).to receive(:puts).with('Do you want to play first? Y for yes')
    allow(game).to receive(:gets) { 'n' }
    game.choose_player_turn
    expect(game.current_player).to be_instance_of ComputerPlayer
    expect(game.current_player.id).to eq 2
  end
end
