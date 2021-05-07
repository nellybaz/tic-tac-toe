require 'rspec'
require_relative '../game/game'

RSpec.describe Game do
  it 'should initialize game with right defaults' do
    game = Game.new
    expect(game.current_player).to eq 1
    expect(game.game_is_playing).to eq false
    expected_valid_games = { '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                             '8' => 8 }
    expect(game.valid_games).to eq expected_valid_games
  end

  it 'should return true for valid moves' do
    game = Game.new
    %w[1 2 3].each do |move|
      expect(game.is_valid_move(move)).to eq true
    end
  end

  it 'should return false for invalid moves' do
    game = Game.new
    %w[10 x f].each do |move|
      expect(game.is_valid_move(move)).to eq false
    end
  end

  it 'should switch player' do
    game = Game.new
    [1, 2, 1].each do |player|
      expect(game.current_player).to eq player
      game.next_player
    end
  end

  it 'should return right symbol for right player' do
    game = Game.new
    %w[X O].each do |symbol|
      expect(game.current_symbol).to eq symbol
      game.next_player
    end
  end

  it 'should return 4 as the computer move' do
    game = Game.new
    game.board.state = %w[X X X X 4 X X X X]
    expect(game.get_computer_move).to eq 4
  end
end
