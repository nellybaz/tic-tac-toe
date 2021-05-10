require_relative './board'

class Game
  def initialize
    puts 'Welcome to Tic-Tac-Toe'
    puts
    @game_is_playing = false
    @current_player = 1
    @board = Board.new
    @valid_games = { '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8 }
  end

  attr_reader :game_is_playing, :current_player, :valid_games

  def current_symbol
    @current_player == 1 ? 'X' : 'O'
  end

  def valid_move?(game)
    @valid_games.key?(game)
  end

  def next_player
    @current_player = if @current_player == 1
                        2
                      else
                        1
                      end
  end

  def start
    @board.draw
    @game_is_playing = true
    while @game_is_playing
      puts game_turn_text

      cell = get_and_validate_user_input

      @board.set_cell(cell, current_symbol)
      @board.draw
      check_winner
      check_draw
      next_player

    end
  end

  def game_turn_text
   "Player #{@current_player}'s turn [1,4,7,0]"
  end

  def check_winner
    if @board.in_winning_state(current_symbol)
      @game_is_playing = false
      puts "Player #{@current_player} won"
      puts 'Game over 😎'
    end
  end

  def check_draw
    if @board.in_draw_state
      @game_is_playing = false
      puts "It's a draw"
      puts 'Game over 😎'
    end
  end

  def get_and_validate_user_input
    is_not_valid_move = true
    is_not_valid_cell = true
    while is_not_valid_move || is_not_valid_cell
      # valid_move?(game) && current_cell != '' && %w[X O].include?(current_cell)
      game = gets.chomp
      if valid_move?(game)
        is_not_valid_move = false
        cell = @valid_games[game]
        current_cell = @board.get_cell(cell)
        if %w[X O].include?(current_cell)
          puts current_cell
          puts 'Cell not empty, retry'
        else
          is_not_valid_cell = false
        end
      else
        puts 'Invalid move, retry'
      end
    end
    cell
  end
end
