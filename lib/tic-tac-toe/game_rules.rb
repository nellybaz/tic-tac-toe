class GameRules
  def self.win?(board, symbol)
    row = row_win?(board, symbol)
    return row if row

    col = column_win?(board, symbol)
    return col if col

    diagonal_win?(board, symbol)
  end

  def self.draw?(board)
    count = 0
    board.state.each do |item|
      count += 1 if %w[X O].include?(item)
    end
    count == board.state.length
  end

  def self.column_win?(board, symbol)
    (0..board.size - 1).each do |index|
      winning_state = true
      (index..board.state.length - 1).step(board.size) do |col_index|
        if board.state[col_index] != symbol
          winning_state = false
          break
        end
      end
      return winning_state if winning_state
    end
    false
  end

  def self.row_win?(board, symbol)
    (0..board.size - 1).each do |index|
      limit = board.size * index
      winning_state = true
      (limit..limit + board.size - 1).each do |i|
        if board.state[i] != symbol
          winning_state = false
          break
        end
      end
      return winning_state if winning_state
    end
    false
  end

  def self.diagonal_win?(board, symbol)
    diag1 = 0
    diag2 = 0
    (0..board.size - 1).each do |i|
      (0..board.size - 1).each do |j|
        index = i * board.size + j
        diag1 += 1 if i == j && board.state[index] == symbol
        diag2 += 1 if i + j == board.size - 1 && board.state[index] == symbol
      end
    end
    diag2 == board.size || diag1 == board.size
  end
end
