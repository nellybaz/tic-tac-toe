class Board
  def initialize
    @state = %w[0 1 2 3 4 5 6 7 8] # TODO: initialize with indices
  end

  attr_accessor :state

  # Draw board
  def draw
    # puts "  "+"abc"
    puts '  ' + '-' * 7
    [0, 1, 2].each do |index|
      puts ' ' + get_row(index)
    end
    puts '  ' + '-' * 7
  end

  # Return content of a given row
  def get_row(index)
    limit = 3 * index
    row_output = '| '
    (limit..limit + 3 - 1).each do |i|
      row_output += @state[i] + ' '
    end
    row_output += '|'
    row_output
  end

  def set_cell(cell, symbol)
    @state[cell] = symbol
  end

  def get_cell(cell)
    @state[cell]
  rescue IndexError => e
    ''
  end

  def in_winning_state(symbol)
    # check row
    winning_state = true

    # index = 0
    (0..2).each do |index|
      limit = 3 * index
      winning_state = true
      (limit..limit + 3 - 1).each do |i|
        if @state[i] != symbol
          winning_state = false
          break
        end
      end
      # don't check again if there's a winning state in one row
      return winning_state if winning_state

      # check col
      winning_state = true
      (index..index + 6).step(3) do |col_index|
        if @state[col_index] != symbol
          winning_state = false
          break
        end
      end
      return winning_state if winning_state
    end

    # check diagonals 1
    winning_state = true
    [0, 4, 8].each do |diag1|
      winning_state = false if @state[diag1] != symbol
    end
    return winning_state if winning_state

    # check diagonals 2
    winning_state = true
    [2, 4, 6].each do |diag2|
      winning_state = false if @state[diag2] != symbol
    end

    winning_state
  end

  def in_draw_state
    count = 0
    @state.each do |item|
      count += 1 if %w[X O].include?(item)
    end
    count == @state.length
  end
end
