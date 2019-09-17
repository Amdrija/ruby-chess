require 'chess_piece.rb'

class Rook < ChessPiece
  attr_reader :castling
  def initialize(square, white = true)
    unicode = white ? '\u2656' : '\u265c'
    super(square, unicode, white)
    @castling = true
  end

  def move(new_square)
    @castling = false if @castling
    super(new_square)
  end

  def move_valid?(new_square)
    horizontal_move?(new_square.position[:y]) || vertical_move?(new_square.position[:x])
  end
end