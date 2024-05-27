# frozen_string_literal: true

require './lib/board'
require './lib/player'

# Represents the game logic for a Tic-Tac-Toe game.
# Manages the game flow, including player turns
# and checking for a winner or tie
class Game
  attr_reader :board, :current_player

  def initialize(first_player, second_player)
    @board = Board.new
    @players = [first_player, second_player]
    @index = 0
    @current_player = @players[@index]
  end

  def winner_in_rows_or_columns?(current_player)
    (0..2).each do |i|
      return true if board.grid[i].all?(current_player.symbol)
      return true if board.grid.transpose[i].all?(current_player.symbol)
    end
    false
  end

  def winner_in_diagonals?(current_player)
    grid = board.grid
    return true if (0..2).map { |i| grid[i][i] }.all?(current_player.symbol)
    return true if (0..2).map { |i| grid[grid.length - 1 - i][i] }.all?(current_player.symbol)

    false
  end

  def player_has_won?
    return true if winner_in_rows_or_columns?(current_player)
    return true if winner_in_diagonals?(current_player)

    false
  end

  def tie?
    board.available_slots.empty?
  end

  def run
    loop do
      current_player.make_move(board)
      board.show
      break puts "#{current_player.name} WINS!" if player_has_won?
      break puts "It's a TIE!" if tie?

      switch_players!
    end
  end

  private

  def switch_players!
    @index = 1 - @index
    @current_player = @players[@index]
  end
end

first_player = Player.new('Player 1', 'X')
second_player = DumbPlayer.new('Dumb Player 2', 'O')

game = Game.new(first_player, second_player)
puts game.run
