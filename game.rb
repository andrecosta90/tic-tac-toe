# frozen_string_literal: true

require './board'
require './player'

def get_player(round_id)
  round_id.even? ? 'X' : 'O'
end

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @players = [Player.new("player 1", "X"), Player.new("player 2", "O")]
    @current_player = 0
  end

  def run
    board.show

    until board.check_winner

      @players[@current_player].play(board)
      @current_player = 1 - @current_player
      board.show
      puts board.check_winner
    end
  end
end

game = Game.new
puts game.run
