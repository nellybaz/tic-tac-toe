class Score
  def initialize(file = File)
    @file = file
    @file_name = 'scores.txt'
    @file_data = @file.read(@file_name).split
    @player1 = @file_data[0].to_i
    @player2 = @file_data[1].to_i
  rescue StandardError => e
    @player1 = 0
    @player2 = 0
    print e
  end

  attr_reader :player1, :player2, :file_name, :file_data

  def retrieve_statistics
    puts "=======\nScores\nPlayer1: #{@player1}\nPlayer2: #{@player2}\n======="
  rescue StandardError => e
    print e
  end

  def record_statistics(winner_id)
    @player1 += 1 if winner_id == 1
    @player2 += 1 if winner_id == 2
    puts @file.write(@file_name, "#{@player1} #{@player2}", mode: 'w')
  rescue StandardError => e
    print e
  end
end
