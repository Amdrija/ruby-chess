class ChessPiece
  attr_reader :unicode, :white
  attr_accessor :position

  def initialize(position = {x: 0, y: 0}, unicode = "", white = true)
    @unicode = unicode
    @position = position
    @white = white
  end

  def move(x, y)
    @position = {x: x, y: y}
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