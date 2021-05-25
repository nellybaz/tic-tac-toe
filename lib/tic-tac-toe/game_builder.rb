require_relative './game'
require_relative './players/player_factory'
require_relative './board'

class GameBuilder
  def board_size
    puts 'Enter the size of the game'
    invalid_input = true
    while invalid_input
      input = gets.chomp
      invalid_input = !Board.valid_board_size?(input)
      puts 'Invalid board size' if invalid_input
    end
    input.to_i
  end

  def game_opponent
    puts 'Choose opponent. [c for computer, s for smart computer, h for human]'
    invalid_input = true
    while invalid_input
      input = gets.chomp
      invalid_input = !PlayerFactory.valid_player_key?(input)
      puts 'Invalid opponent key' if invalid_input
    end
    PlayerFactory.make(key: input, id: 2, symbol: 'O')
  end

  def create
    player = PlayerFactory.make(key: 'h', id: 1, symbol: 'X')
    board = Board.new(board_size)
    Game.new(player, game_opponent, board).start
  end
end
