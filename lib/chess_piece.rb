require 'square.rb'
class ChessPiece
  attr_reader :unicode, :white
  attr_accessor :square

  def initialize(square, unicode = '', white = true)
    @unicode = unicode
    @square = square
    square.occupy(self)
    @white = white
  end

  def move(square)
    @square = square
    square.occupy(self)
  end

  def horizontal_move?(position_y)
    square.position[:y] == position_y
  end

  def vertical_move?(position_x)
    square.position[:x] == position_x
  end

  def diagonal_move?(position_x, position_y)
    (square.position[:x] - position_x).abs == (square.position[:y] - position_y).abs
  end
end