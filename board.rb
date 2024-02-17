
# frozen_string_literal: true

class Board
  attr_reader :available_slots, :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, '_') }
    @available_slots = 9
  end

  def show
    puts(grid.map { |x| x.join(' | ') })
    puts
  end

  def change_state(row, col, value)
    if (row >= 3 || col >= 3)
      return false
    end
    # raise StandardError, "Invalid position :: row=#{row} col=#{col}" if row >= 3 || col >= 3
    # raise StandardError, 'No more slots available' if @available_slots <= 0
    # raise StandardError, 'This slot is already occupied' if grid[row][col] != '_'

    @grid[row][col] = value
    @available_slots -= 1
    true
  end

  def check_winner
    element = check_rows_and_columns
    return element if element

    element = check_diagonals
    return element if element

    "DRAW" if available_slots <= 0
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

  # def self.check_array(array)
  #   array[0] unless array.length > 1 || array.include?('_')
  # end

  # def self.check_rows_and_columns(matrix)
  #   (0..2).each do |i|
  #     element = check_array(matrix[i].uniq)
  #     return element if element

  #     transposed_matrix = matrix.transpose
  #     element = check_array(transposed_matrix[i].uniq)
  #     return element if element
  #   end
  #   nil
  # end

  # def self.check_diagonals(matrix)
  #   element = check_array((0..2).map { |i| matrix[i][i] }.uniq)
  #   return element if element

  #   check_array((0..2).map { |i| matrix[matrix.length - 1 - i][i] }.uniq)
  # end

  # def self.check_winner(matrix)
  #   element = check_rows_and_columns(matrix)
  #   return element if element

  #   check_diagonals(matrix)
  # end
end

# board = Board.new

# board.show
# puts board.available_slots

# board.change_state(0, 0, 'O')
# board.show
# puts board.available_slots
# # p board.check_winner

# board.change_state(0, 1, 'X')
# board.show
# puts board.available_slots
# # p board.check_winner

# board.change_state(1, 0, 'O')
# board.show
# puts board.available_slots
# # p board.check_winner

# board.change_state(0, 2, 'X')
# board.show
# puts board.available_slots
# # p board.check_winner

# board.change_state(2, 0, 'O')
# board.show
# puts board.available_slots
# p board.check_winner



# # board.change_state(2, 3, 'O')
# # board.show
# # p board.check_winner
# # p Board.check_winner(a.transpose)
