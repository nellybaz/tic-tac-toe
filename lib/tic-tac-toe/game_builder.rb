require_relative './game'
require_relative './players/player_factory'
require_relative './board'

class GameBuilder
  def board_size
    puts 'Enter the size of the game'
    input = gets.chomp
    puts 'Invalid board size' unless valid_size input
    input.to_i
  end

  def valid_size(value)
    Float(value) && value.to_i > 2
  rescue StandardError
    false
  end

  def game_opponent
    puts 'Choose opponent. [c for computer, s for smart computer, h for human]'
    input = gets.chomp
    puts 'Invalid opponent key' unless valid_opponent_key input
    PlayerFactory.make(key: input, id: 2, symbol: 'O')
  end

  def valid_opponent_key(value)
    %w[c s h].include?(value)
  end

  def create
    player = PlayerFactory.make(key: 'h', id: 1, symbol: 'X')
    board = Board.new(board_size)
    Game.new(player, game_opponent, board).start
  end
end
