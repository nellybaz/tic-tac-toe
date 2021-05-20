require_relative './board'
require_relative './players/player_factory'
require_relative './score'

class Game
  def initialize(
    player1 = PlayerFactory.make(key: 'h', id: 1, symbol: 'X'),
    player2 = PlayerFactory.make(key: 'h', id: 2,
                                 symbol: 'O'),
    board = Board.new(3),
    score = Score.new
  )
    puts 'Welcome to Tic-Tac-Toe'
    @game_is_playing = false
    @player1 = player1
    @player2 = player2
    @current_player = @player1
    @board = board
    @score = score
    @is_draw = false
  end

  attr_reader :game_is_playing, :current_player, :board, :score

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

  def choose_player_turn
    unless @player2.instance_of? HumanPlayer
      puts 'Do you want to play first? Y for yes'
      input = gets.chomp
      decision = (input == 'Y') || (input == 'y')
      next_player unless decision
    end
    @current_player.id
  end

  def start
    choose_player_turn
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
    if @player2.instance_of?(ComputerPlayer)
      'computer'
    else
      @player2.instance_of?(SmartComputerPlayer) ? 'smart_computer' : 'human'
    end
  end

  def game_turn_text
    if !@player2.instance_of?(HumanPlayer) && !@current_player.instance_of?(HumanPlayer)
      "Computer's turn"
    else
      !@player2.instance_of?(HumanPlayer) && !!@current_player.instance_of?(HumanPlayer) ? 'Your turn' : "Player #{@current_player.id}'s turn [e.g 1,4,7,0]"
    end
  end

  def game_winner_text
    if !@player2.instance_of?(HumanPlayer) && !@current_player.instance_of?(HumanPlayer)
      '🤖 Computer 🤖 won'
    else
      !@player2.instance_of?(HumanPlayer) && !!@current_player.instance_of?(HumanPlayer) ? 'You won' : "Player #{@current_player.id} won"
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
