class ComputerPlayer
  def initialize(id, symbol)
    @id = id
    @symbol = symbol
  end

  attr_reader :id, :symbol

  def move(board)
    move = board.unselected_cells.sample.to_i
    puts "🤖 Computer played #{move} 🤖"
    move
  end

  def human?
    false
  end

  def key
    'computer'
  end

  def self.random1 # TODO: better naming 
    ComputerPlayer.new(1, 'X')
  end

  def self.random2
    ComputerPlayer.new(2, 'O')
  end
end
