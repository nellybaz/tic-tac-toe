require_relative '../lib/tic-tac-toe/board_drawer'
require_relative '../lib/tic-tac-toe/board'

RSpec.describe BoardDrawer do
  it 'should draw the board currently' do
    horizontal_border = '  ----------------'
    expect(BoardDrawer).to receive(:puts).with(horizontal_border)
    [' | 0    1    2    |', ' | 3    4    5    |', ' | 6    7    8    |'].each do |row_output|
      expect(BoardDrawer).to receive(:puts).with(row_output)
    end
    expect(BoardDrawer).to receive(:puts).with(horizontal_border)

    BoardDrawer.draw(Board.new(3))
  end

  it 'should get row content space' do
    expect(BoardDrawer.row_content_space(0)).to eq ' ' * 4
    expect(BoardDrawer.row_content_space(11)).to eq ' ' * 3
  end

  it 'should get rows of empty game state' do
    space = BoardDrawer.row_content_space(0)
    [[0, "| 0#{space}1#{space}2#{space}|"], [1, "| 3#{space}4#{space}5#{space}|"]].each do |index, resolve|
      expect(BoardDrawer.get_row(Board.new(3), index)).to eq resolve
    end
  end
end
