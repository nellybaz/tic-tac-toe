require_relative './computer_player'
require_relative './human_player'
require_relative './smart_computer_player'

class PlayerFactory
  def self.make(key, id: 1, symbol: 'X')
    case key
    when 'c'
      ComputerPlayer.new(id, symbol)
    when 'h'
      HumanPlayer.new(id, symbol)
    when 's'
      SmartComputerPlayer.new(id, symbol)
    else
      HumanPlayer.new(id, symbol)
    end
  end
end
