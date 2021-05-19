require_relative '../lib/tic-tac-toe/game_builder'
game_opponent_text = 'Choose opponent. [c for computer, C for smart computer, h for human]'


RSpec.describe GameBuilder do
  let(:game_builder) { GameBuilder.new }

  it 'builds board size from input' do
    expect(game_builder).to receive(:puts).with('Enter the size of the game')
    allow(game_builder).to receive(:gets) { '5' }
    game_builder.build_board_size
    expect(game_builder.game_baord_size).to eq 5
  end

  it 'returns an error on board size less than 3' do
    expect(game_builder).to receive(:puts).with('Enter the size of the game')
    allow(game_builder).to receive(:gets) { '2' }
    expect(game_builder).to receive(:puts).with('Invalid board size')
    game_builder.build_board_size
  end

  it 'returns an error on wrong board size' do
    expect(game_builder).to receive(:puts).with('Enter the size of the game')
    allow(game_builder).to receive(:gets) { '1' }
    expect(game_builder).to receive(:puts).with('Invalid board size')
    game_builder.build_board_size
  end

  xit 'returns error on invalid game opponent key' do
    expect(game_builder).to receive(:puts).with('Choose opponent. [c for computer, C for smart computer, h for human]')

  end

  it 'oponent should be human player when h is choosen' do
    expect(game_builder).to receive(:puts).with(game_opponent_text)
    allow(game_builder).to receive(:gets) { '1' }
    expect(game_builder).to receive(:puts).with('Invalid opponent key')
    expect(game_builder.game_opponent).to eq nil
  end
end
