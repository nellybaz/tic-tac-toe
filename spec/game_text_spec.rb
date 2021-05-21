require_relative '../lib/tic-tac-toe/game_text'
require_relative '../lib/tic-tac-toe/players/human_player'
require_relative '../lib/tic-tac-toe/players/computer_player'

RSpec.describe GameText do
  it 'prints correct game turn text' do
    player1 = HumanPlayer.new(1, 'X')
    player2 = ComputerPlayer.new(2, 'O')
    expect(GameText.player_turn_text(player1, player2)).to eq 'Your turn'

    expect(GameText.player_turn_text(player2, player1)).to eq "Computer's turn"

    expect(GameText.player_turn_text(player1, HumanPlayer.new(2, 'O'))).to eq "Player 1's turn [e.g 1,4,7,0]"
    expect(GameText.player_turn_text(HumanPlayer.new(2, 'O'), player1)).to eq "Player 2's turn [e.g 1,4,7,0]"
  end

  it 'prints correct game winner text' do
    player1 = HumanPlayer.new(1, 'X')
    player2 = ComputerPlayer.new(2, 'O')
    expect(GameText.game_winner_text(player1, player2)).to eq 'You won'

    expect(GameText.game_winner_text(player2, player1)).to eq '🤖 Computer 🤖 won'

    expect(GameText.game_winner_text(player1, HumanPlayer.new(2, 'O'))).to eq 'Player 1 won'
    expect(GameText.game_winner_text(HumanPlayer.new(2, 'O'), player1)).to eq 'Player 2 won'
  end
end
