# frozen_string_literal: true

# Represents a player in a game.
# Each player has a name, a symbol representing their marker on the board,
# and a reference to the game board.
class Player
  attr_reader :name, :symbol, :board

  def initialize(name, symbol, board)
    @name = name
    @symbol = symbol
    @board = board
  end

  def make_move
    loop do
      puts "Waiting for #{name} ( #{symbol} ) :"

      row, col = select_candidate
      break if board.change_state(row, col, self)

      puts 'Invalid move! Try again!'
      puts ''
    end
    board.check_winner
  end

  def to_s
    symbol
  end

  private

  def select_candidate
    gets.split(',').map(&:to_i)
  end
end

# Represents a computer player that makes random moves on the board.
# Inherits from the Player class.
class DumbPlayer < Player
  private

  def select_candidate
    sleep(1)
    board.available_slots.sample
  end
end
