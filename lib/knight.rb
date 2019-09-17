require './lib/chess_piece.rb'

class Knight < ChessPiece
  def initialize(square, white = true)
    unicode = white ? "\u2658" : "\u265e"
    super(square, unicode, white)
  end

  def move_valid?(new_square)
    x_distance = (square.position[:x] - new_square.position[:x]).abs
    y_distance = (square.position[:y] - new_square.position[:y]).abs
    (x_distance == 2 && y_distance == 1) || (x_distance == 1 && y_distance == 2)
  end
end