require_relative './game'
require_relative './players/player_factory'
require_relative './board'

class GameBuilder
  def board_size
    puts 'Enter the size of the game'
    input = gets.chomp
    puts 'Invalid board size' unless Board.valid_baord_size? input
    input.to_i
  end

  def game_opponent
    puts 'Choose opponent. [c for computer, s for smart computer, h for human]'
    input = gets.chomp
    puts 'Invalid opponent key' unless PlayerFactory.valid_player_key? input
    PlayerFactory.make(key: input, id: 2, symbol: 'O')
  end

  def create
    player = PlayerFactory.make(key: 'h', id: 1, symbol: 'X')
    board = Board.new(board_size)
    Game.new(player, game_opponent, board).start
  end
end
