require_relative '../lib/tic-tac-toe/score'
require 'tempfile'
file_name = 'scores.json'
require 'json'

RSpec.describe Score do
  score = nil
  file = nil
  content_json = nil
  score_content = nil
  before(:each) do
    score_content = '{
            "human": {
              "player1": 3,
              "player2": 2,
              "draw":0
            },
            "computer": {
              "human": 0,
              "computer": 0,
              "draw":0
            },
            "smart_computer": {
              "human": 1,
              "computer": 1,
              "draw":0
            }
          }'
    content_json = JSON.parse score_content
    file = double(File)
    expect(file).to receive(:read).with(file_name).and_return(score_content)
    score = Score.new(file)
  end

  it 'should print game scores correctly' do
    expect(score).to receive(:puts).with("=======\nScores\n\n\nHUMAN\n\nplayer1: 3\nplayer2: 2\ndraw: 0\n\nCOMPUTER\n\nhuman: 0\ncomputer: 0\ndraw: 0\n\nSMART_COMPUTER\n\nhuman: 1\ncomputer: 1\ndraw: 0\n=======\n")
    score.retrieve_statistics
  end

  it 'should record player 1 as winner' do
    winner_index = 0
    game_key = 'human'

    new_content =
      '{
        "human": {
          "player1": 4,
          "player2": 2,
          "draw":0
        },
        "computer": {
          "human": 0,
          "computer": 0,
          "draw":0
        },
        "smart_computer": {
          "human": 1,
          "computer": 1,
          "draw":0
        }
      }'

    new_content = JSON.parse new_content
    expect(file).to receive(:write).with(file_name, new_content.to_json, { mode: 'w' })

    expect(score.file_data).to eq score_content

    expect(score.record_statistics(game_key, winner_index)).to eq 4
  end

  it 'should record a draw' do
    winner_index = -1
    game_key = 'human'

    new_content =
      '{
        "human": {
          "player1": 3,
          "player2": 2,
          "draw":1
        },
        "computer": {
          "human": 0,
          "computer": 0,
          "draw":0
        },
        "smart_computer": {
          "human": 1,
          "computer": 1,
          "draw":0
        }
      }'

    new_content = JSON.parse new_content
    expect(file).to receive(:write).with(file_name, new_content.to_json, { mode: 'w' })

    expect(score.file_data).to eq score_content

    expect(score.record_statistics(game_key, winner_index)).to eq 1
  end

  it 'should retrieve content keys correctly' do
    expect(score.retrieve_content_keys('human')).to eq [['player1', 3], ['player2', 2], ['draw', 0]]
    expect(score.retrieve_content_keys('computer')).to eq [['human', 0], ['computer', 0], ['draw', 0]]
    expect(score.retrieve_content_keys('smart_computer')).to eq [['human', 1], ['computer', 1], ['draw', 0]]
  end
end
