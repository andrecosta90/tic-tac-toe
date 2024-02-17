# frozen_string_literal: true

require './board'

def get_player(round_id)
  round_id.even? ? 'X' : 'O'
end

class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def run
    board.show
    round = 0

    result = board.check_winner
    until result
      current_player = get_player(round)
      # puts "Current player #{current_player}"
      # row, col = gets.split(',').map(&:to_i)
      # round += 1
      board.change_state(row, col, current_player)
      board.show
      result = board.check_winner
    end
    result
  end
end

game = Game.new
puts game.run
