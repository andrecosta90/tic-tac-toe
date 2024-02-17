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
    @players = [Player.new('Player 1', 'X'), Player.new('Player 2', 'O')]
    @current_player = 0
  end

  def run
    board.show

    until board.check_winner

      result = @players[@current_player].make_move(board)
      @current_player = 1 - @current_player
      board.show
    end

    result[:tie] ? (puts "It's a TIE!") : (puts "#{result[:winner].name} WINS!")
  end
end

game = Game.new
puts game.run
