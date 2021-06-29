require_relative './tic-tac-toe/board'
require_relative './tic-tac-toe/game_rules'
require_relative './tic-tac-toe/players/computer_player'
require_relative './tic-tac-toe/players/smart_computer_player'

class TicTacToe
  def self.hi
    puts 'Hi there from tic-tac-toe'
  end

  def self.move(type, state, symbol)
    board_size = Math.sqrt(state.length)
    board = Board.new(board_size.to_i)
    board.state = state
      
    if GameRules.win?(board, 'X') || GameRules.win?(board, 'O')
      return {
        game_state:'win'
      }


   elsif GameRules.draw?(board)
      return {
        game_state:'draw'
      }
    end

    move = type == 'computer' ? ComputerPlayer.new(1,symbol).move(board) : SmartComputerPlayer.new(1, symbol).move(board)
    return {
      move:move,
      game_state:'playing'
      }
  end

  def self.valid_move?(state, move)
    board = Board.new(3)
    board.state = state
    board.unselected_cells.include?(move)
  end

  # Refactor initilizing and then assign
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
