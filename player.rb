# frozen_string_literal: true

class Player

  attr_reader :name, :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol

  end

  def make_move()
    gets.split(',').map(&:to_i)
  end

  def play(board)
    puts "Aguardando o #{name} jogar: #{symbol}"
    row, col = make_move
    puts
    board.change_state(row, col, self)
  end

  def to_s
    symbol
  end

end
