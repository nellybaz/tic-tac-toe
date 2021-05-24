require_relative '../game_rules'
require_relative '../move_validator'

class Minimax
  def self.evaluate_board(board)
    return -10 if GameRules.diagonal_win?(board,
                                          'X') || GameRules.row_win?(board, 'X') || GameRules.column_win?(board, 'X')
    return  10 if GameRules.diagonal_win?(board,
                                          'O') || GameRules.row_win?(board, 'O') || GameRules.column_win?(board, 'O')

    0
  end

  def self.run(board, depth, is_max)
    score = evaluate_board board
    return score if [10, -10].include?(score)

    return 0 if board.moves_left? == false

    best = is_max ? -Float::INFINITY : Float::INFINITY

    (0..board.size - 1).each do |i|
      (0..board.size - 1).each do |j|
        index = i * board.size + j
        next unless MoveValidator.valid_move?(board, board.state[index])

        symbol = is_max ? 'O' : 'X'
        board.set_cell(index, symbol)

        move_options = [best, run(board, depth + 1, !is_max)]
        best = is_max ? move_options.max : move_options.min

        board.set_cell(index, index.to_s)
      end
    end
    best
  end
end
