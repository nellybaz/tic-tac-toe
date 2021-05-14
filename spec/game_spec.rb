require 'rspec'
require_relative '../lib/tic-tac-toe/game'

RSpec.describe Game do
  game = nil
  before(:each) do
    expect($stdout).to receive(:puts).with('Welcome to Tic-Tac-Toe')
    game = Game.new
  end

  # it 'should initialize game with right defaults' do
  #   expect(game.current_player).to eq 1
  #   expect(game.game_is_playing).to eq false
  #   expected_valid_games = { '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
  #                            '8' => 8 }
  #   expect(game.valid_games).to eq expected_valid_games
  # end

  it 'should switch player' do
    [1, 2, 1].each do |player|
      expect(game.current_player.id).to eq player
      game.next_player
    end
  end

  it 'should verify that scores are initialized to zero' do
    expect(game.score.player1).to eq 0
    expect(game.score.player2).to eq 0
  end

  it 'should return right symbol for right player' do
    %w[X O].each do |symbol|
      expect(game.current_symbol).to eq symbol
      game.next_player
    end
  end

  it 'should have the against_computer property be true when user inputs Y' do
    expect(game).to receive(:puts).with('Enter Y to play against the computer')
    allow(game).to receive(:gets) { 'Y' }
    expect(game.play_against_computer).to eq 'Y'
    expect(game.against_computer).to eq true
  end

  it 'should have the against_computer property be false when user does not input Y' do
    expect(game).to receive(:puts).with('Enter Y to play against the computer')
    allow(game).to receive(:gets) { 'asd' }
    expect(game.play_against_computer).to eq 'asd'
    expect(game.against_computer).to eq false
  end

  it 'should set computer as current player if human is not playing first' do
    expect(game).to receive(:puts).with('Enter Y to play against the computer')
    allow(game).to receive(:gets) { 'Y' }
    expect(game.play_against_computer).to eq 'Y'
    expect(game.against_computer).to eq true

    expect(game).to receive(:puts).with('Do you want to play first? Y for yes')
    allow(game).to receive(:gets) { 'n' }
    game.choose_player
    expect(game.current_player.is_computer).to eq true
  end

  it 'should have 1 returned by choose_player method if not playing against the computer' do
    expect(game).to receive(:puts).with('Enter Y to play against the computer')
    allow(game).to receive(:gets) { 'n' }
    expect(game.play_against_computer).to eq 'n'
    expect(game.against_computer).to eq false
    expect(game.choose_player).to eq 1
    expect(game.current_player.id).to eq 1
  end

  it 'should change set board size to user input' do
    expect(game).to receive(:puts).with('Enter board size: [Minimum is 3]')
    allow(game).to receive(:gets) { '6' }
    game.change_board_size
    expect(game.board.state.length).to eq 36
  end

end
