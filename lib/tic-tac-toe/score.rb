require 'json'

class Score
  def initialize(file = File)
    @file = file
    @file_name = 'scores.json'
    @file_data = @file.read(@file_name)
  rescue StandardError => e
    print 'error from score initializer'
    print e
  end

  attr_reader :player1, :player2, :file_name, :file_data

  def retrieve_content_keys(key = 'human')
    json_content = JSON.parse @file_data
    content = json_content[key]
    output = []
    content.each_key do |game_key|
      output << [game_key, content[game_key]]
    end
    output
  rescue StandardError => e
    puts 'Error from retrieve content keys'
    print e
    []
  end

  def print_game_scores
    puts retrieve_scores
  end

  def retrieve_scores
    json_content = JSON.parse @file_data
    output = "=======\nScores\n\n"
    json_content.each_key do |key|
      output += "\n#{key.upcase}\n\n"
      game = json_content[key]
      game.each_key do |game_key|
        output += "#{game_key}: #{game[game_key]}\n"
      end
    end
    output += "=======\n"
  rescue StandardError => e
    print e
  end

  def record_game_scores(key, winner_id)
    new_content = JSON.parse @file_data
    content_keys_and_value = retrieve_content_keys(key)
    new_score = content_keys_and_value[winner_id][1] + 1
    new_content[key][content_keys_and_value[winner_id][0]] = new_score
    @file.write(@file_name, new_content.to_json, mode: 'w')
    new_score
  rescue StandardError => e
    puts 'Error from record statistics'
    print e
    -1
  end
end
