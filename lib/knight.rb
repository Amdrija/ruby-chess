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

  def check(squares)
    offsets = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]]

    offsets.each do |offset|
      new_x = @square.position[:x] + offset[0]
      new_y = @square.position[:y] + offset[1]

      squares[new_y][new_x].checked = true if coordinates_valid?(new_x, new_y)
    end
  end
end