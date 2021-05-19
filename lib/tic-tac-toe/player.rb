# A player class
class Player
  def initialize(symbol, id, is_computer: false, is_smart_computer: false)
    @symbol = symbol
    @id = id
    @is_computer = is_computer
    @is_smart_computer = is_smart_computer
  end

  attr_reader :is_computer, :symbol, :id

  def user_input
    gets.chomp
  end

  def move(board)
    return smart_computer_move(board) if @is_smart_computer

    return computer_move(board) if @is_computer

    human_move(board)
  end

  def computer_move(board)
    move = rand(9)
    current_cell = board.get_cell(move)
    while %w[X O].include?(current_cell)
      move = rand(9)
      current_cell = board.get_cell(move)
    end
    puts "🤖 Computer played #{move} 🤖"
    move
  end

  def human_move(board)
    is_not_valid_move = true
    is_not_valid_cell = true
    while is_not_valid_move || is_not_valid_cell
      game = user_input
      if valid_move?(game)
        is_not_valid_move = false
        current_cell = board.get_cell(game.to_i)
        if %w[X O].include?(current_cell)
          puts 'Cell not empty, retry'
        else
          is_not_valid_cell = false
        end
      else
        puts 'Invalid move, retry'
      end
    end
    game.to_i
  end

  def valid_move?(game)
    Float(game)
    true
  rescue StandardError
    false
  end

  def smart_computer_move(board)
    best_val = -1000
    best_move = -1

    (0..board.size - 1).each do |i|
      (0..board.size - 1).each do |j|
        index = i * board.size + j
        next unless board.numeric?(board.state[index])

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
          next unless board.numeric?(board.state[index])

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
          next unless board.numeric?(board.state[index])

          board.set_cell(index, @symbol == 'X' ? 'O' : 'X')

          best = [best, minimax(board, depth + 1, !is_max)].min

          board.set_cell(index, index.to_s)
        end
      end
    end
    best
  end
end
