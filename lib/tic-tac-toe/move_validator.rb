class MoveValidator
  def self.valid_move?(board, move)
    Float(move) < board.size * board.size
  rescue StandardError
    false
  end
end
