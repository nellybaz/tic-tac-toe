require_relative './game'
require_relative './player_factory'

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
    puts 'Choose opponent. [c for computer, C for smart computer, h for human]'
    input = gets.chomp
    puts 'Invalid opponent key' unless valid_opponent_key input
    nil
  end

  def valid_opponent_key(value)
    %w[c s h].include?(value)
  end

  def run
    build_board_size
    game_opponent
    Game.new(Player)
  end
end
