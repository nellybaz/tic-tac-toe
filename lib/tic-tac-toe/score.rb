require 'json'

class Score
  def initialize(file = File)
    @file = file
    @file_name = 'scores.json'
    @file_data = @file.read(@file_name)
    @json_content = JSON.parse @file_data
  rescue StandardError => e
    print 'error from score initializer'
    print e
  end

  attr_reader :player1, :player2, :file_name, :file_data

  def retrieve_content_keys(key = 'human')
    content = @json_content[key]
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
    output = "=======\nScores\n\n"
    @json_content.each_key do |key|
      output += "\n#{key.upcase}\n\n"
      @json_content[key].each_key do |game_key|
        output += "#{game_key}: #{@json_content[key][game_key]}\n"
      end
    end
    puts output += "=======\n"
  rescue StandardError => e
    print e
  end

  def record_game_scores(key, winner_id)
    content_keys_and_value = retrieve_content_keys(key)
    new_score = content_keys_and_value[winner_id][1] + 1
    @json_content[key][content_keys_and_value[winner_id][0]] = new_score
    @file.write(@file_name, @json_content.to_json, mode: 'w')
    new_score
  rescue StandardError => e
    puts 'Error from record statistics'
    print e
    -1
  end
end
