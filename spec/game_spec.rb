require 'rspec'
require_relative '../game/game'

RSpec.describe Game do
  it 'should initialize game with right defaults' do
    game = Game.new
    game.current_player.should == 1
    game.game_is_playing.should == false
    game.valid_games.should == { '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                                 '8' => 8 }
  end

  it 'should return true for valid moves' do
    game = Game.new
    game.valid_move?('1').should == true
    game.valid_move?('2').should == true
  end

  it 'should return false for invalid moves' do
    game = Game.new
    game.valid_move?('10').should == false
    game.valid_move?('x').should == false
  end

  it 'should switch player' do
    game = Game.new
    game.current_player.should == 1
    game.next_player
    game.current_player.should == 2
    game.next_player
    game.current_player.should == 1
  end

  it 'should return right symbol for right player' do
    game = Game.new
    game.current_symbol.should == 'X'
    game.next_player
    game.current_symbol.should == 'O'
  end
end
