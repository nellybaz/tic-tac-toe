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
    return score if [10, -10].include?(score)

    return 0 if board.moves_left? == false

    best = is_max ? -Float::INFINITY : Float::INFINITY

    (0..board.size - 1).each do |i|
      (0..board.size - 1).each do |j|
        index = i * board.size + j
        next unless board.valid_move?(board.state[index])

        opponent_symbol = @symbol == 'X' ? 'O' : 'X'
        symbol = is_max ? @symbol : opponent_symbol
        board.set_cell(index, symbol)

        move_options = [best, minimax(board, depth + 1, !is_max)]
        best = is_max ? move_options.max : move_options.min

        board.set_cell(index, index.to_s)
      end
    end
    best
  end
end
