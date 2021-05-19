# A player class
class Player
  def initialize(symbol, id, is_computer: false)
    @symbol = symbol
    @id = id
    @is_computer = is_computer
  end

  attr_reader :is_computer, :symbol, :id

  def user_input
    gets.chomp
  end

  def move(board)
    @is_computer ? computer_move(board) : human_move(board)
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
    best_move
  end

  def minimax(board, depth, isMax)
    4
  end
end
