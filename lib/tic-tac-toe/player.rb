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
end
