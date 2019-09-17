require 'chess_piece.rb'

class Bishop < ChessPiece
  def initialize(square, white = true)
    unicode = white ? '\u2657' : '\u265d'
    super(square, unicode, white)
  end

  def move_valid?(new_square)
    diagonal_move?(new_square.position[:x], new_square.position[:y])
  end
end