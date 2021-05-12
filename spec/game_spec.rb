require 'rspec'
require_relative '../lib/tic-tac-toe/game'

RSpec.describe Game do
  game = Game.new
  before(:each) do
    expect($stdout).to receive(:puts).with('Welcome to Tic-Tac-Toe')
    game = Game.new
  end

  it 'should initialize game with right defaults' do
    expect(game.current_player).to eq 1
    expect(game.game_is_playing).to eq false
    expected_valid_games = { '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                             '8' => 8 }
    expect(game.valid_games).to eq expected_valid_games
  end

  it 'should return true for valid moves' do
    %w[1 2 3].each do |move|
      expect(game.valid_move?(move)).to eq true
    end
  end

  it 'should return false for invalid moves' do
    %w[10 x f].each do |move|
      expect(game.valid_move?(move)).to eq false
    end
  end

  it 'should switch player' do
    [1, 2, 1].each do |player|
      expect(game.current_player).to eq player
      game.next_player
    end
  end

  it 'should return right symbol for right player' do
    %w[X O].each do |symbol|
      expect(game.current_symbol).to eq symbol
      game.next_player
    end
  end

  it 'should return 4 as the computer move' do
    expect($stdout).to receive(:puts).with('🤖 Computer played 4 🤖')

    game.board.state = %w[X X X X 4 X X X X]
    expect(game.get_computer_move).to eq 4
  end

  it 'should have the against_computer property be true when user inputs Y' do
    expect(game).to receive(:puts).with('Enter Y to play against the computer')
    allow(game).to receive(:gets) { 'Y' }
    expect(game.play_against_computer).to eq 'Y'
    expect(game.againts_computer).to eq true
  end
end
