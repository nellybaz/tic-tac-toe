class SmartComputerPlayer
  def initialize(id, symbol)
    @id = id
    @symbol = symbol
  end

  attr_reader :id, :symbol

  def move(board)
    best_val = -1000
    best_move = -1

    (0..board.size - 1).each do |i|
      (0..board.size - 1).each do |j|
        index = i * board.size + j
        next unless board.valid_move?(board.state[index])

        board.set_cell(index, @symbol)
        move_val = minimax(board, 0, false)
        board.set_cell(index, index.to_s)

        if move_val > best_val
          best_move = index
          best_val = move_val
        end
      end
    end
    puts "🤖 Computer played #{best_move} 🤖"
    best_move
  end

  def minimax(board, depth, is_max)
    score = board.minimax_evaluate_board
    return score if score == 10

    return score if score == -10

    return 0 if board.moves_left? == false

    if is_max
      best = -Float::INFINITY
      # -1000

      (0..board.size - 1).each do |i|
        (0..board.size - 1).each do |j|
          index = i * board.size + j
          next unless board.valid_move?(board.state[index])

          board.set_cell(index, @symbol)

          best = [best, minimax(board, depth + 1, !is_max)].max

          board.set_cell(index, index.to_s)
        end
      end
      best
    else
      best = Float::INFINITY
      (0..board.size - 1).each do |i|
        (0..board.size - 1).each do |j|
          index = i * board.size + j
          next unless board.valid_move?(board.state[index])

          board.set_cell(index, @symbol == 'X' ? 'O' : 'X')

          best = [best, minimax(board, depth + 1, !is_max)].min

          board.set_cell(index, index.to_s)
        end
      end
    end
    best
  end
end
