require_relative './board'

class Game
  def initialize
    puts 'Welcome to Tic-Tac-Toe'
    @game_is_playing = false
    @current_player = 1
    @board = Board.new(3)
    @againts_computer = false
  end

  attr_reader :game_is_playing, :current_player, :board, :againts_computer

  def current_symbol
    @current_player == 1 ? 'X' : 'O'
  end

  def valid_move?(game)
    Float(game) && game.to_i < board.state.length && game.to_i >= 0
  rescue StandardError
    false
  end

  def next_player
    @current_player = if @current_player == 1
                        2
                      else
                        1
                      end
  end

  def user_input
    gets.chomp
  end

  def play_against_computer
    puts 'Enter Y to play against the computer'
    decision = user_input
    @againts_computer = (decision == 'Y') || (decision == 'y')
    decision
  end

  def choose_player
    if @againts_computer
      puts 'Do you want to play first?'
      input = user_input
      decision = (input == 'Y') || (input == 'y')
      next_player if decision
    end
    @current_player
  end

  def change_board_size
    puts 'Enter board size: [Minimum is 3]'
    is_valid_size = false
    until is_valid_size
      input = user_input
      is_valid_size = true if Float(input) && input.to_i >= 3
    end
    @board = Board.new(input.to_i)
  end

  def start
    change_board_size
    play_against_computer
    choose_player
    @board.draw
    @game_is_playing = true
    while @game_is_playing
      puts game_turn_text

      if @againts_computer && @current_player == 1
        move = get_computer_move
        cell = move
      else
        cell = get_and_validate_user_input
      end

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
    is_not_valid_move = true
    is_not_valid_cell = true
    while is_not_valid_move || is_not_valid_cell
      game = user_input
      if valid_move?(game)
        is_not_valid_move = false
        current_cell = @board.get_cell(game.to_i)
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

  def get_computer_move
    move = rand(9)
    current_cell = @board.get_cell(move)
    while %w[X O].include?(current_cell)
      move = rand(9)
      current_cell = @board.get_cell(move)
    end
    puts "🤖 Computer played #{move} 🤖"
    move
  end
end
