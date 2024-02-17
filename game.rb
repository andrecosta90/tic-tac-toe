# frozen_string_literal: true

require './board'
require './player'

# Represents the game logic for a Tic-Tac-Toe game.
# Manages the game flow, including player turns and checking for a winner or tie
class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @players = [Player.new('Player 1', 'X', @board), DumbPlayer.new('Dumb Player 2', 'O', @board)]
    @current_player = 0
  end

  def run
    board.show

    result = board.check_winner
    until result
      result = @players[@current_player].make_move
      @current_player = 1 - @current_player
      board.show
    end

    result[:tie] ? (puts "It's a TIE!") : (puts "#{result[:winner].name} WINS!")
  end
end

game = Game.new
puts game.run
