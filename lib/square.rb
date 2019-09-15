# Square class
class Square
  attr_reader :piece, :position, :white

  def initialize(position = { x: 0, y: 0 }, piece = nil, white = true)
    @position = position
    @piece = piece
    @white = white
  end

  def occupy(piece)
    unless occupied?
      @piece = piece
      return nil
    end

    eaten_piece = @piece
    @piece = piece
    eaten_piece
  end

  def occupied_by_same_color?(piece)
    return false unless occupied?
    piece.white == @piece.white
  end

  def occupied_by_different_color?(piece)
    return false unless occupied?
    piece.white != @piece.white
  end

  private
  def occupied?
    !@piece.nil?
  end
end