class ChessPiece
  attr_reader :unicode
  attr_accessor :position

  def initialize(unicode = "", position = {x: 0, y: 0})
    @unicode = unicode
    @position = position
  end

  def horizontal_move?(x, y)
    position[:y] == y
  end

  def vertical_move?(x, y)
    position[:x] == x
  end

  def diagonal_move?(x, y)
    (position[:x] - x).abs == (position[:y] - y).abs
  end
end