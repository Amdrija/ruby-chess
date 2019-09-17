require './lib/chess_piece.rb'

class Queen < ChessPiece
  def initialize(square, white = true)
    unicode = white ? '\u2655' : '\u265b'
    super(square, unicode, white)
  end

  def move_valid?(new_square)
    x = new_square.position[:x]
    y = new_square.position[:y]
    horizontal_move?(y) || vertical_move?(x) || diagonal_move?(x, y)
  end
end