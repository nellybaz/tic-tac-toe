class GameText
  def self.player_turn_text(current_player, player2)
    if !current_player.human?
      "Computer's turn"
    else
      !player2.human? && current_player.human? ? 'Your turn' : "Player #{current_player.id}'s turn [e.g 1,4,7,0]"
    end
  end

  def self.game_winner_text(current_player, player2)
    if !current_player.human?
      '🤖 Computer 🤖 won'
    else
      !player2.human? && current_player.human? ? 'You won' : "Player #{current_player.id} won"
    end
  end

  def self.print_scores(score)
    score.print_game_scores
  end

  def self.game_over
    puts 'Game over 😎'
  end

  def self.draw
    puts "It's a draw"
  end

  def self.welcome
    puts 'Welcome to Tic-Tac-Toe'
  end
end
