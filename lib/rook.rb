require './lib/chess_piece.rb'

class Rook < ChessPiece
  attr_reader :castling
  def initialize(square, white = true)
    unicode = white ? "\u2656" : "\u265c"
    super(square, unicode, white)
    @castling = true
  end

  def check(squares)
    offsets = [[1, 0], [-1, -0], [0, 1], [0, -1]]
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

  def move(new_square)
    @castling = false if @castling
    super(new_square)
  end

  def move_valid?(new_square)
    horizontal_move?(new_square.position[:y]) || vertical_move?(new_square.position[:x])
  end
end