require_relative './tic-tac-toe/board'
require_relative './tic-tac-toe/game_rules'
require_relative './tic-tac-toe/players/computer_player'
require_relative './tic-tac-toe/players/smart_computer_player'

class TicTacToe
  def self.hi
    puts 'Hi there from tic-tac-toe'
  end

  def self.symbol_delta(board)
    first_symbol_count = 0
    second_symbol_count = 0
    board.each do |symbol|
      first_symbol_count += 1 if symbol == 'X'
      second_symbol_count += 1 if symbol == 'O'
    end

    diff = first_symbol_count - second_symbol_count
    return (diff).abs
  end

  def self.board_has_valid_state(board)
    return symbol_delta(board) < 2
  end

  def self.move(type, state, symbol)
    board_size = Math.sqrt(state.length)
    board = Board.new(board_size.to_i)
    board.state = state
      
    unless board_has_valid_state(state)
      return {
        game_state:'invalid_board'
      }
    end

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
