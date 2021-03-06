require_relative './board'
require_relative './players/player_factory'
require_relative './score'
require_relative './game_text'
require_relative './board_drawer'
require_relative './game_rules'

class Game
  def initialize(
    player1 = PlayerFactory.make(key: 'h', id: 1, symbol: 'X'),
    player2 = PlayerFactory.make(key: 'h', id: 2,
                                 symbol: 'O'),
    board = Board.new(3),
    score = Score.new
  )
    GameText.welcome
    @game_is_playing = false
    @player1 = player1
    @player2 = player2
    @current_player = @player1
    @board = board
    @score = score
    @is_draw = false
  end

  attr_reader :game_is_playing, :current_player, :board, :scores

  def current_symbol
    @current_player.symbol
  end

  def next_player
    @current_player = if @current_player.id == @player1.id
                        @player2
                      else
                        @player1
                      end
  end

  def choose_player_turn
    unless @player2.human?
      GameText.first_player_decision_text
      input = gets.chomp
      decision = (input == 'Y') || (input == 'y')
      next_player unless decision
    end
    @current_player.id
  end

  def start
    choose_player_turn
    GameText.print_scores(@score)
    BoardDrawer.draw(@board)
    @game_is_playing = true
    while @game_is_playing
      GameText.player_turn_text(@current_player, @player2)
      current_player_move = @current_player.move(@board)

      @board.set_cell(current_player_move, current_symbol)
      BoardDrawer.draw(@board)
      check_draw unless check_winner
      next_player if @game_is_playing
    end
    winner_id = @is_draw ? -1 : @current_player.id - 1
    @score.record_game_scores(@current_player.key, winner_id)
  end

  def check_winner
    if GameRules.win?(@board, current_symbol)
      @game_is_playing = false
      GameText.game_winner_text(@current_player, @player2)
      GameText.game_over
      true
    end
    false
  end

  def check_draw
    if @game_is_playing && GameRules.draw?(@board)
      @game_is_playing = false
      @is_draw = true
      GameText.draw
      GameText.game_over
    end
  end
end
