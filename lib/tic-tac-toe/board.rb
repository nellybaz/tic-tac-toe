require_relative './move_validator'

class Board
  def initialize(size)
    @size = size
    @state = %w[0 1 2 3 4 5 6 7 8]
    if size > 3
      tmp = []
      (0..size * size - 1).each do |index|
        tmp << index
      end
      @state = tmp
    end
  end

  attr_reader :size
  attr_accessor :state

  def set_cell(cell, symbol)
    @state[cell] = symbol
  end

  def unselected_cells
    @state.reject { |cell| %w[X O].include?(cell) }
  end

  def moves_left?
    (0..@size - 1).each do |i|
      (0..@size - 1).each do |j|
        index = i * @size + j
        return true if MoveValidator.valid_move?(self, @state[index])
      end
    end
    false
  end

  def self.valid_board_size?(value)
    Float(value) && value.to_i > 2
  rescue StandardError
    false
  end
end
