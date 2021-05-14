require_relative '../lib/tic-tac-toe/player'

RSpec.describe Player do
  it 'should initialize a humam player with X symbol' do
    player = Player.new('X', 1)
    expect(player.is_computer).to eq false
    expect(player.symbol).to eq 'X'
  end

  it 'should initialize a computer player with X symbol' do
    player = Player.new('X', 1, is_computer: true)
    expect(player.is_computer).to eq true
    expect(player.symbol).to eq 'X'
  end

  it 'should make a valid move for human player' do
    player = Player.new('X', 1)
    expect(player.is_computer).to eq false
    expect(player.symbol).to eq 'X'
    allow(player).to receive(:gets) { '4' }
    board = Board.new(3)
    expect(player.move(board)).to eq 4
  end

  it 'should return 4 as the computer move' do
    player = Player.new('X', 1, is_computer: true)
    expect(player.is_computer).to eq true
    expect(player.symbol).to eq 'X'
    expect(player).to receive(:puts).with('🤖 Computer played 4 🤖')
    board = Board.new(3)
    board.state = %w[X X X X 4 X X X X]
    expect(player.move(board)).to eq 4
  end

  it 'should return true for valid moves' do
    player = Player.new('X', 1)
    %w[1 2 3].each do |move|
      expect(player.valid_move?(move)).to eq true
    end
  end


  it 'should return false for invalid moves' do
    player = Player.new('X', 1)
    ['x', '=', 'a'].each do |move|
      expect(player.valid_move?(move)).to eq false
    end
  end
end
