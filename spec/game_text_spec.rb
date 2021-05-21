require_relative '../lib/tic-tac-toe/game_text'
require_relative '../lib/tic-tac-toe/players/human_player'
require_relative '../lib/tic-tac-toe/players/computer_player'

RSpec.describe GameText do
  it 'prints correct game turn text' do
    player1 = HumanPlayer.new(1, 'X')
    player2 = ComputerPlayer.new(2, 'O')

    expect(GameText).to receive(:puts).with('Your turn')
    GameText.player_turn_text(player1, player2)

    expect(GameText).to receive(:puts).with("Computer's turn")
    GameText.player_turn_text(player2, player1)

    expect(GameText).to receive(:puts).with("Player 1's turn [e.g 1,4,7,0]")
    GameText.player_turn_text(player1, HumanPlayer.new(2, 'O'))

    expect(GameText).to receive(:puts).with("Player 2's turn [e.g 1,4,7,0]")
    GameText.player_turn_text(HumanPlayer.new(2, 'O'), player1)
  end

  it 'prints correct game winner text' do
    player1 = HumanPlayer.new(1, 'X')
    player2 = ComputerPlayer.new(2, 'O')

    expect(GameText).to receive(:puts).with('You won')
    GameText.game_winner_text(player1, player2)

    expect(GameText).to receive(:puts).with('🤖 Computer 🤖 won')
    GameText.game_winner_text(player2, player1)

    expect(GameText).to receive(:puts).with('Player 1 won')
    GameText.game_winner_text(player1, HumanPlayer.new(2, 'O'))

    expect(GameText).to receive(:puts).with('Player 2 won')
    GameText.game_winner_text(HumanPlayer.new(2, 'O'), player1)
  end

  it 'prints correct game over text' do
    expect(GameText).to receive(:puts).with('Game over 😎')
    GameText.game_over
  end

  it 'prints correct draw text' do
    expect(GameText).to receive(:puts).with("It's a draw")
    GameText.draw
  end

  it 'prints correct welcome text' do
    expect(GameText).to receive(:puts).with('Welcome to Tic-Tac-Toe')
    GameText.welcome
  end

  it 'prints correct player turn text' do
    expect(GameText).to receive(:puts).with('Do you want to play first? Y for yes')
    GameText.first_player_decision_text
  end
end
