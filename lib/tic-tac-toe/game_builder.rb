class GameBuilder
  def initialize
    @game_baord_size = 3
  end

  attr_reader :game_baord_size

  def build_board_size
    puts 'Enter the size of the game'
    input = gets.chomp
    puts 'Invalid board size' unless valid_size input
    @game_baord_size = input.to_i
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
    %w[c C h].include?(value)
  end
end
