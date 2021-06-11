require_relative './tic-tac-toe/game_text'
require_relative './tic-tac-toe/board'
require_relative './tic-tac-toe/game_rules'
require_relative './tic-tac-toe/players/computer_player'
require_relative './tic-tac-toe/players/smart_computer_player'

class TicTacToe
  def self.hi
    puts 'Hi there from tic-tac-toe 2'
    GameText.game_over
  end


  def self.draw?(state)
    board = Board.new(3)
    board.state = state
    GameRules.draw?(board)
  end

  def self.win?(state, symbol)
    board = Board.new(3)
    board.state = state
    GameRules.win?(board, symbol)
  end

  def self.computer_move(state, player_id, player_symbol)
    board = Board.new(3)
    board.state = state
    ComputerPlayer.new(player_id, player_symbol).move(board)
  end

  def self.smart_computer_move(state, player_id, player_symbol)
    board = Board.new(3)
    board.state = state
    SmartComputerPlayer.new(player_id, player_symbol).move(board)
  end

end
