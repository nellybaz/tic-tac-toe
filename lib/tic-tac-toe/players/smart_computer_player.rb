require_relative '../algorithms/minimax'

class SmartComputerPlayer
  def initialize(id, symbol)
    @id = id
    @symbol = symbol
  end

  attr_reader :id, :symbol

  def move(board)
    best_val = -1000
    best_move = -1

    (0..board.size - 1).each do |i|
      (0..board.size - 1).each do |j|
        index = i * board.size + j
        next unless board.valid_move?(board.state[index])

        board.set_cell(index, @symbol)
        move_val = Minimax.run(board, 0, false)
        board.set_cell(index, index.to_s)

        if move_val > best_val
          best_move = index
          best_val = move_val
        end
      end
    end
    puts "🤖 Computer played #{best_move} 🤖"
    best_move
  end

  def human?
    false
  end

  def key
    'smart_computer'
  end

  def self.random1
    SmartComputerPlayer.new(1, 'X')
  end

  def self.random2
    SmartComputerPlayer.new(2, 'O')
  end
end
