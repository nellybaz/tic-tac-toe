require_relative '../lib/tic-tac-toe/score'
require 'tempfile'
file_name = 'scores.txt'

RSpec.describe Score do
  it 'should initialize scores to zero' do
    score = Score.new
    expect(score.player1).to eq 0
    expect(score.player2).to eq 0
  end

  it 'should print game scores correctly' do
    file = double(File)
    file_open = double('File.open')
    expect(file_open).to receive(:split).and_return(%w[4 2])
    expect(file).to receive(:read).with(file_name).and_return(file_open)
    score = Score.new(file)
    expect(score).to receive(:puts).with("=======\nScores\nPlayer1: #{score.player1}\nPlayer2: #{score.player2}\n=======")
    score.retrieve_statistics
  end

  it 'should record player 1 as winner' do
    file = double(File)
    file_open = double('File.open')
    expect(file_open).to receive(:split).and_return(%w[1 0])
    expect(file).to receive(:read).with(file_name).and_return(file_open)
    expect(file).to receive(:write).with(file_name, '2 0', { mode: 'w' })
    score = Score.new(file)
    expect(score.file_data).to eq %w[1 0]

    score.record_statistics(1)

    expect(score.player1).to eq 2
  end

  it 'should read file correctly when initialized' do
    file = double(File)
    file_open = double('File.open')
    expect(file_open).to receive(:split).and_return(%w[1 0])
    expect(file).to receive(:read).with(file_name).and_return(file_open)
    score = Score.new(file)
    expect(score.file_data).to eq %w[1 0]
  end
end
