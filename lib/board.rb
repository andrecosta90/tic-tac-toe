# frozen_string_literal: true

class InvalidMoveError < StandardError; end

# Represents a Tic-Tac-Toe board.
# The board maintains the game state,
# and tracks available slots.
class Board
  attr_reader :available_slots, :grid

  def initialize(verbose: true)
    @grid = Array.new(3) { Array.new(3, '_') }
    @available_slots = (0..2).to_a.product((0..2).to_a)
    @verbose = verbose
  end

  def show
    return unless @verbose

    puts
    puts(grid.map { |x| x.join(' | ') })
    puts
  end

  def change_state(row, col, value)
    raise InvalidMoveError, 'Invalid move: row or column value is nil' if row.nil? || col.nil?
    raise InvalidMoveError, 'Invalid move: out of range' if row >= 3 || col >= 3
    raise InvalidMoveError, 'Invalid move: slot already taken' unless available_slots.include?([row, col])

    @grid[row][col] = value
    @available_slots.delete([row, col])
    true
  end
end
