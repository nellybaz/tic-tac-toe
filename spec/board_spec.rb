require_relative "../game/board.rb"

RSpec.describe Board do
    [[0, '|012|'],[1, '|345|'],[2, '|678|']].each do |index, resolve|
        it "should get row #{index} of empty game state" do
            Board.new.get_row(index).should == resolve
        end

    end


    it "should set board state" do
        new_state = ['x','x','x','.','.','.','.','.','.']
        board = Board.new
        board.state = new_state
        board.state.should == new_state
        board.get_row(0).should == '|xxx|'
    end

    it "should set cell" do
        board = Board.new
        board.get_cell(0).should == '0'
        board.set_cell(0, 'x')
        board.get_cell(0).should == 'x'
    end


end