# frozen_string_literal: true

require './lib/player'
require './lib/game'

first_player = Player.new('Player 1', 'X')
second_player = DumbPlayer.new('Dumb Player 2', 'O')

game = Game.new(first_player, second_player)
puts game.run
