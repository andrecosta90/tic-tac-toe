# frozen_string_literal: true

class Board
  attr_reader :available_slots, :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, '_') }
    @available_slots = (0..2).to_a.product((0..2).to_a)
  end

  def show
    puts(grid.map { |x| x.join(' | ') })
    puts
  end

  def change_state(row, col, value)
    return false if row >= 3 || col >= 3 || !available_slots.include?([row, col])

    @grid[row][col] = value
    @available_slots.delete([row, col])
    true
  end

  def check_winner
    element = check_rows_and_columns
    return { tie: false, winner: element } if element

    element = check_diagonals
    return { tie: false, winner: element } if element

    { tie: true, winner: nil } if available_slots.empty?
  end

  private

  def check_array(array)
    array[0] unless array.length > 1 || array.include?('_')
  end

  def check_diagonals
    element = check_array((0..2).map { |i| grid[i][i] }.uniq)
    return element if element

    check_array((0..2).map { |i| grid[grid.length - 1 - i][i] }.uniq)
  end

  def check_rows_and_columns
    (0..2).each do |i|
      element = check_array(grid[i].uniq)

      return element if element

      element = check_array(grid.transpose[i].uniq)
      return element if element
    end
    nil
  end
end
