require_relative './computer_player'
require_relative './human_player'
require_relative './smart_computer_player'

class PlayerFactory
  def self.make(key: 'h', id: 1, symbol: 'X')
    factory_hash = { 'c' => ComputerPlayer, 'h' => HumanPlayer, 's' => SmartComputerPlayer }
    factory_hash.fetch(key, HumanPlayer).new(id, symbol)
  end

  def self.valid_player_key?(value)
    %w[c s h].include?(value)
  end
end
