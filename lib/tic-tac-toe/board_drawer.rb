class BoardDrawer
  def self.draw(board)
    puts horizontal_border board
    (0..board.size - 1).each do |index|
      puts " #{get_row(board, index)}"
    end
    puts horizontal_border board
  end

  def self.horizontal_border(board)
    boarder_length = get_row(board, 0).length - 2
    "  #{'-' * boarder_length}"
  end

  def self.get_row(board, index)
    limit = board.size * index
    space = row_content_space(0)
    row_output = '| '
    (limit..limit + board.size - 1).each do |i|
      space = row_content_space(i)
      row_output += "#{board.state[i]}#{space}"
    end
    row_output += '|'
    row_output
  end

  def self.row_content_space(index)
    index > 9 ? ' ' * 3 : ' ' * 4
  end
end
