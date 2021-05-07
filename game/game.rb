require_relative './board'

class Game
  def initialize
    puts 'Welcome to Tic-Tac-Toe'
    puts
    @game_is_playing = false
    @current_player = 1
    @board = Board.new
    @valid_games = { '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8 }
    @againts_computer = false
  end

  attr_reader :game_is_playing, :current_player, :valid_games, :board

  def current_symbol
    @current_player == 1 ? 'X' : 'O'
  end

  def is_valid_move(game)
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
    puts 'Enter Y to play against the computer'
    decision = gets.chomp
    @againts_computer = true if (decision == 'Y') || (decision == 'y')

    @board.draw
    @game_is_playing = true
    while @game_is_playing
      puts game_turn_text

      cell = get_and_validate_user_input

      @board.set_cell(cell, current_symbol)
      @board.draw
      check_draw unless check_winner
      next_player

    end
  end

  def game_turn_text
    if @againts_computer && @current_player == 1
      "Computer's turn"
    else
      @againts_computer && @current_player == 2 ? 'Your turn' : "Player #{@current_player}'s turn [e.g 1,4,7,0]"
    end
  end

  def game_winner_text
    if @againts_computer && @current_player == 1
      '🤖 Computer 🤖 won'
    else
      @againts_computer && @current_player == 2 ? 'You won' : "Player #{@current_player} won"
    end
  end

  def check_winner
    if @board.in_winning_state(current_symbol)
      @game_is_playing = false
      puts game_winner_text
      puts 'Game over 😎'
      true
    end
    false
  end

  def check_draw
    if @board.in_draw_state
      @game_is_playing = false
      puts "It's a draw"
      puts 'Game over 😎'
    end
  end

  def get_and_validate_user_input
    # If computer is playing, make move here
    if @againts_computer && @current_player == 1
      cell = get_computer_move
      puts "🤖 Computer played #{cell} 🤖"
      return cell
    end

    move = gets.chomp
    until is_valid_move(move)
      puts 'Invalid move, retry'
      move = gets.chomp
    end

    cell = @valid_games[move]
    current_cell = @board.get_cell(cell)
    while %w[X O].include?(current_cell)
      puts 'Cell is not empty, please retry'
      move = gets.chomp

      # simply this
      cell = @valid_games[move]
      current_cell = @board.get_cell(cell)
    end

    cell
  end

  def get_computer_move
    move = rand(9)
    current_cell = @board.get_cell(move)
    while %w[X O].include?(current_cell)
      move = rand(9)
      current_cell = @board.get_cell(move)
    end

    move
  end
end
