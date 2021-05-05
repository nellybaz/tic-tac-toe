require_relative "../game/board.rb"

RSpec.describe Board do
    [0,1,2].each do |index|
        it "should get row #{index} of empty game state" do
            Board.new.get_row(index).should == "|...|"
        end

    end


    it "should set board state" do
        new_state = ['x','x','x','.','.','.','.','.','.']
        board = Board.new
        board.state = new_state
        board.state.should == new_state
        board.get_row(0).should == '|xxx|'
    end

end