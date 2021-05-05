require "rspec"
require_relative "../game/game"


RSpec.describe Game do
    it "should initialize game with right defaults" do
        game = Game.new
        game.current_player.should == 1
        game.game_is_playing.should == false
        game.valid_games.should == {"a0" => 0, "b0" => 1, "c0"=>2, "a1"=>3, "b1"=>4, "c1"=>5, "a2"=>6, "b2"=>7, "c2"=>8}
    end

    it "should return true for valid moves" do
        game = Game.new
        game.is_valid_move("a1").should == true
        game.is_valid_move("c2").should == true
    end

    it "should return false for invalid moves" do
        game = Game.new
        game.is_valid_move("x1").should == false
        game.is_valid_move("42").should == false
    end

    it "should switch player" do
        game = Game.new
        game.current_player.should == 1
        game.next_player()
        game.current_player.should == 2
        game.next_player()
        game.current_player.should == 1

    end

    it "should return right symbol for right player" do
        game = Game.new
        game.current_symbol.should == 'x'
        game.next_player()
        game.current_symbol.should == 'o'

    end
    
end
