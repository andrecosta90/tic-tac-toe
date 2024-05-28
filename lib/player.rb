# frozen_string_literal: true

# Represents a player in a game.
# Each player has a name, a symbol representing their marker on the board,
# and a reference to the game board.
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def make_move(board)
    loop do
      puts "Waiting for #{name} ( #{symbol} ) :"
      row, col = select_candidate(board)
      begin
        board.change_state(row, col, symbol)
        break
      rescue InvalidMoveError
        puts 'Invalid move! Try again!'
      end
    end
  end

  private

  def select_candidate(_)
    gets.split(',').map(&:to_i)
  end
end

# Represents a computer player that makes random moves on the board.
# Inherits from the Player class.
class DumbPlayer < Player
  private

  def select_candidate(board)
    sleep(1)
    board.available_slots.sample
  end
end
