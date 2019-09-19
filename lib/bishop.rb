require './lib/chess_piece.rb'

class Bishop < ChessPiece
  def initialize(square, white = true)
    unicode = white ? "\u2657" : "\u265d"
    super(square, unicode, white)
  end

  def move_valid?(new_square)
    diagonal_move?(new_square.position[:x], new_square.position[:y])
  end

  def check(squares)
    offsets = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    offsets.each do |offset|
      new_x = @square.position[:x] + offset[0]
      new_y = @square.position[:y] + offset[1]
      while coordinates_valid?(new_x, new_y) && !squares[new_y][new_x].occupied?
        squares[new_y][new_x].checked = true
        new_x += offset[0]
        new_y += offset[1]
      end
      squares[new_y][new_x].checked = true if coordinates_valid?(new_x, new_y)
    end
  end
end