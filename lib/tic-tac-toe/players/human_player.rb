class HumanPlayer
  def initialize(id, symbol)
    @id = id
    @symbol = symbol
  end

  attr_reader :id, :symbol

  def move(board)
    is_not_valid_move = true
    is_not_valid_cell = true
    while is_not_valid_move || is_not_valid_cell
      user_move = gets.chomp
      if board.valid_move?(user_move)
        is_not_valid_move = false
        current_cell = board.get_cell(user_move.to_i)
        if %w[X O].include?(current_cell)
          puts 'Cell not empty, retry'
        else
          is_not_valid_cell = false
        end
      else
        puts 'Invalid move, retry'
      end
    end
    user_move.to_i
  end

  def human?
    true
  end
end
