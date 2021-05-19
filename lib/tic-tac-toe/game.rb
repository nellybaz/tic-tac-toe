require_relative './board'
require_relative './player'
require_relative './score'

class Game
  def initialize
    puts 'Welcome to Tic-Tac-Toe'
    @game_is_playing = false
    @player1 = Player.new('X', 1)
    @player2 = Player.new('O', 2)
    @current_player = @player1
    @board = Board.new(3)
    @against_computer = false
    @score = Score.new
    @is_draw = false
  end

  attr_reader :game_is_playing, :current_player, :board, :against_computer, :score

  def current_symbol
    @current_player.symbol
  end

  def next_player
    @current_player = if @current_player.id == 1
                        @player2
                      else
                        @player1
                      end
  end

  def user_input
    gets.chomp
  end

  def play_against_computer
    puts 'Enter Y to play against the computer'
    decision = user_input
    @against_computer = (decision == 'Y') || (decision == 'y')
    @player2 = Player.new('O', 2, is_computer: true) if @against_computer
    decision
  end

  def choose_player
    if @against_computer
      puts 'Do you want to play first? Y for yes'
      input = user_input
      decision = (input == 'Y') || (input == 'y')
      next_player unless decision
    end
    @current_player.id
  end

  def change_board_size
    puts 'Enter board size: [Minimum is 3]'
    is_valid_size = false
    until is_valid_size
      input = user_input
      begin
        Float(input)
        if input.to_i >= 3
          is_valid_size = true
        else
          puts 'Invalid input, retry'
        end
      rescue StandardError
        puts 'Invalid input, retry'
      end
    end
    @board = Board.new(input.to_i)
  end

  def start
    change_board_size
    play_against_computer
    choose_player
    print_scores
    @board.draw
    @game_is_playing = true
    while @game_is_playing
      puts game_turn_text
      cell = @current_player.move(@board)

      @board.set_cell(cell, current_symbol)
      @board.draw
      check_draw unless check_winner
      next_player if @game_is_playing
    end
    winner_id = @is_draw ? -1 : @current_player.id - 1
    @score.record_statistics(game_score_key, winner_id)
  end

  def game_score_key
    @against_computer ? 'computer' : 'human'
  end

  def game_turn_text
    if @against_computer && @current_player.is_computer
      "Computer's turn"
    else
      @against_computer && !@current_player.is_computer ? 'Your turn' : "Player #{@current_player.id}'s turn [e.g 1,4,7,0]"
    end
  end

  def game_winner_text
    if @against_computer && @current_player.is_computer
      '🤖 Computer 🤖 won'
    else
      @against_computer && !@current_player.is_computer ? 'You won' : "Player #{@current_player.id} won"
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
    if @game_is_playing && @board.in_draw_state
      @game_is_playing = false
      @is_draw = true
      puts "It's a draw"
      puts 'Game over 😎'
    end
  end

  def print_scores
    @score.retrieve_statistics
  end
end
