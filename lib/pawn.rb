require "./lib/chess_piece.rb"
class Pawn < ChessPiece
  attr_reader :opening_move

  def initialize(square, white = true)
    unicode = white ? "\u2659" : "\u265f"
    super(square, unicode, white)
    @opening_move = true
  end

  # returns the eaten chess piece, otherwise nil
  def move(new_square)
    @opening_move = false if opening_move
    super(new_square)
  end

  def move_valid?(new_square)

    horizontal_move?(new_square) || opening_move?(new_square) || eating_move?(new_square)

    # TODO: add move for en_passant
  end

  def check(squares)
    vertical_step = white ? 1 : -1
    horizontal_steps = [-1, 1]

    horizontal_steps.each do |horizontal_step|
      new_x = @square.position[:x] + horizontal_step
      new_y = @square.position[:y] + vertical_step

      squares[new_y][new_x].checked = true if coordinates_valid?(new_x, new_y)
    end
  end

  private
  def eating_move?(new_square)
    new_square.occupied_by_different_color?(self) && diagonal_move?(new_square)
  end

  # diagonal eating move,if the pawn is white, it can go upwards and left/right
  # otherwise,if the pawn is black, it can go downwards and left/right
  def diagonal_move?(new_square)
    if @white
      return  (new_square.position[:x] - @square.position[:x]).abs == 1 &&
              new_square.position[:y] - @square.position[:y] == 1
    end

    (new_square.position[:x] - @square.position[:x]).abs == 1 &&
        new_square.position[:y] - @square.position[:y] == -1
  end

  def horizontal_move?(new_square)
    return false if new_square.occupied?

    if @white
      return new_square.position[:x] == @square.position[:x] &&
          new_square.position[:y] == @square.position[:y] + 1
    end

    new_square.position[:x] == @square.position[:x] &&
        new_square.position[:y] == @square.position[:y] - 1
  end

  def opening_move?(new_square)
    return false if !@opening_move || new_square.occupied?

    if @white
      return new_square.position[:x] == @square.position[:x] &&
          new_square.position[:y] == @square.position[:y] + 2
    end

    new_square.position[:x] == @square.position[:x] &&
        new_square.position[:y] == @square.position[:y] - 2
  end
end