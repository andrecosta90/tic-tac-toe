# frozen_string_literal: true

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def make_move(board)
    loop do
      puts "Waiting for #{name} ( #{symbol} ) :"
      row, col = gets.split(',').map(&:to_i)

      break if board.change_state(row, col, self)

      puts "row=#{row} col=#{col}"
      puts board.available_slots.include?([row, col])
      puts 'Invalid move! Try again!'
      puts ''
    end
    board.check_winner
  end

  def to_s
    symbol
  end
end
