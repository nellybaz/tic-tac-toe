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

  it 'returns error on invalid game opponent key' do
    expect(game_builder).to receive(:puts).with('Choose opponent. [c for computer, C for smart computer, h for human]')
    allow(game_builder).to receive(:gets) { 'k' }
    expect(game_builder).to receive(:puts).with('Invalid opponent key')
    game_builder.game_opponent
  end

  it 'oponent should be human player when h is choosen' do
    expect(game_builder).to receive(:puts).with(game_opponent_text)
    allow(game_builder).to receive(:gets) { 'h' }
    expect(game_builder.game_opponent).to eq nil
  end

  it 'test valid board size' do
    [[3, true], [2, false], ['d', false]].each do |size, resolve|
      expect(game_builder.valid_size(size)).to eq resolve
    end
  end

  it 'test valid opponent key' do
    [['c', true], ['K', false], ['C', false], ['h', true], ['s', true]].each do |key, resolve|
      expect(game_builder.valid_opponent_key(key)).to eq resolve
    end
  end
end
