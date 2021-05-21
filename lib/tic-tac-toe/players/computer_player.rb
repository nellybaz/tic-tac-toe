class ComputerPlayer
  def initialize(id, symbol)
    @id = id
    @symbol = symbol
  end

  attr_reader :id, :symbol

  def move(board)
    board_length = board.size * board.size
    move = rand(board_length)
    current_cell = board.get_cell(move)
    while %w[X O].include?(current_cell)
      move = rand(board_length)
      current_cell = board.get_cell(move)
    end
    puts "🤖 Computer played #{move} 🤖"
    move
  end

  def human?
    false
  end

  def key
    'computer'
  end

  def self.random1
    ComputerPlayer.new(1, 'X')
  end

  def self.random2
    ComputerPlayer.new(2, 'O')
  end
end
