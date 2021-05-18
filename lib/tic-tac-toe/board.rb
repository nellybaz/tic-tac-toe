class Board
  def initialize(size)
    @size = size
    @state = %w[0 1 2 3 4 5 6 7 8]
    if size > 3
      tmp = []
      (0..size * size - 1).each do |index|
        tmp << index
      end
      @state = tmp
    end
  end

  attr_reader :size
  attr_accessor :state

  def horizontal_border
    boarder_length = get_row(0).length - 2
    "  #{'-' * boarder_length}"
  end

  def row_content_space(index)
    index > 9 ? ' ' * 3 : ' ' * 4
  end

  def draw
    puts horizontal_border
    (0..@size - 1).each do |index|
      puts " #{get_row(index)}"
    end
    puts horizontal_border
  end

  def get_row(index)
    limit = @size * index
    space = row_content_space(0)
    row_output = '| '
    (limit..limit + @size - 1).each do |i|
      space = row_content_space(i)
      row_output += "#{@state[i]}#{space}"
    end
    row_output += '|'
    row_output
  end

  def set_cell(cell, symbol)
    @state[cell] = symbol
  end

  def get_cell(cell)
    @state[cell]
  end

  def in_winning_state(symbol)
    row = row_win?(symbol)
    return row if row

    col = col_win?(symbol)
    return col if col

    diagonal_win(symbol)
  end

  def row_win?(symbol)
    winning_state = true
    (0..@size - 1).each do |index|
      limit = @size * index
      winning_state = true
      (limit..limit + @size - 1).each do |i|
        if @state[i] != symbol
          winning_state = false
          break
        end
      end
      return winning_state if winning_state
    end
    false
  end

  def col_win?(symbol)
    winning_state = true
    (0..@size - 1).each do |index|
      winning_state = true
      (index..@state.length - 1).step(@size) do |col_index|
        if @state[col_index] != symbol
          winning_state = false
          break
        end
      end
      return winning_state if winning_state
    end
    false
  end

  def diagonal_win(symbol)
    diag1 = 0
    diag2 = 0
    (0..@size - 1).each do |i|
      (0..@size - 1).each do |j|
        index = i * @size + j
        diag1 += 1 if i == j && @state[index] == symbol
        diag2 += 1 if i + j == @size - 1 && @state[index] == symbol
      end
    end
    diag2 == @size || diag1 == @size
  end

  def in_draw_state
    count = 0
    @state.each do |item|
      count += 1 if %w[X O].include?(item)
    end
    count == @state.length
  end

  def moves_left?
    (0..@size - 1).each do |i|
      (0..@size - 1).each do |j|
        index = i * @size + j
        return true if numeric?(@state[index])
      end
    end
    false
  end

  def numeric?(val)
    Float(val)
    true
  rescue StandardError
    false
  end

  def minimax_evaluate_board
    return 1 if diagonal_win('X') || row_win?('X') || col_win?('X')
    return -1 if diagonal_win('O') || row_win?('O') || col_win?('O')

    0
  end
end
