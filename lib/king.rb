require './lib/chess_piece.rb'

class King < ChessPiece
  attr_accessor :castling
  def initialize(square, white = true)
    unicode = white ? '\u2654' : '\u265a'
    super(square, unicode, white)
    @castling = true
  end

  def move(new_square)
    @castling = false if @castling
    super(new_square)
  end

  def move_valid?(new_square)
    x_distance = (new_square.position[:x] - @square.position[:x]).abs
    y_distance = (new_square.position[:y] - @square.position[:y]).abs
    x_distance <= 1 && y_distance <= 1
  end
end