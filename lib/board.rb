require './lib/bishop.rb'
require './lib/king.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/queen.rb'
require './lib/rook.rb'
require './lib/square.rb'
require 'colorize'

class Board
  attr_accessor :squares, :white_pieces, :black_pieces
  def initialize
    reset
  end

  def reset
    reset_board
    reset_pieces(true)
    reset_pieces(false)
  end

  def display
    system("clear")
    puts "   0  1  2  3  4  5  6  7"
    @squares.each_with_index do |row, i|
      print "#{("A".ord + i).chr} "
      row.each do |square|
        background = square.white ? :red : :blue
        print square.to_s.colorize(:background => background)
      end
      puts
    end
  end

  def move_valid?(square_start, square_end)
    return false if !square_start.occupied? || square_end.occupied_by_king?

    return false unless square_start.piece.move_valid?(square_end)

    return true if square_start.piece.class == Pawn ||
        square_start.piece.class == King ||
        square_start.piece.class == Knight

    !blocks?(square_start, square_end)
  end

  def parse_board_for_check(white)
    reset_square_checks
    pieces = white ? @white_pieces : @black_pieces
    pieces.each do |piece|
      piece.check(@squares)
    end
  end

  private

  def reset_square_checks
    squares.each do |row|
      row.each do |square|
        square.checked = false
      end
    end
  end

  def blocks?(square_start, square_end)
    horizontal_step, vertical_step = *direction(square_start,square_end)

    return sub_diagonal_blocks?(square_start, square_end) if vertical_step == -1

    position_y = square_end.position[:y]
    position_x = square_end.position[:x]

    while position_y <= square_start.position[:y] && position_x <= square_start.position[:x]
      return true if @squares[position_y][position_x].occupied? && @squares[position_y][position_x] != square_start

      position_x += horizontal_step
      position_y += vertical_step
    end

    while position_y >= square_start.position[:y] && position_x >= square_start.position[:x]
      return true if @squares[position_y][position_x].occupied? && @squares[position_y][position_x] != square_start

      position_x -= horizontal_step
      position_y -= vertical_step
    end

    false
  end

  def direction(square_start, square_end)
    start_x = square_start.position[:x]
    start_y = square_start.position[:y]
    end_x = square_end.position[:x]
    end_y = square_end.position[:y]
    return [1, 0] if start_y == end_y
    return [0, 1] if start_x == end_x
    return [1, 1] if start_x - end_x == start_y - end_y

    [1, -1]
  end

  def sub_diagonal_blocks?(square_start, square_end)
    position_y = square_end.position[:y]
    position_x = square_end.position[:x]

    while position_y < square_start.position[:y] && position_x > square_start.position[:x]
      return true if @squares[position_y][position_x].occupied?

      position_x -= 1
      position_y += 1
    end

    while position_y > square_start.position[:y] && position_x < square_start.position[:x]
      return true if @squares[position_y][position_x].occupied?

      position_x += 1
      position_y -= 1
    end
    false
  end

  #if the coordinates of square is x, y, then we access that square with squares[y][x]
  def reset_board
    @squares = []
    8.times do |i|
      @squares.push([])
      8.times do |j|
        square = Square.new({ x: j, y: i}, nil, (i + j).even?)
        @squares[i].push(square)
      end
    end
  end

  def reset_pieces(white)

    if white
      row = 0
      @white_pieces = []
      pieces = @white_pieces
    else
      row = 7
      @black_pieces = []
      pieces = @black_pieces
    end
    reset_pawns(white, pieces)

    pieces << Rook.new(@squares[row][0], white)
    pieces << Rook.new(@squares[row][7], white)

    pieces << Knight.new(@squares[row][1], white)
    pieces << Knight.new(@squares[row][6], white)

    pieces << Bishop.new(@squares[row][2], white)
    pieces << Bishop.new(@squares[row][5], white)

    pieces << Queen.new(@squares[row][3], white)
    pieces << King.new(@squares[row][4], white)
  end

  def reset_pawns(white, pieces)
    row = white ? 1 : 6
    8.times do |i|
      pieces << Pawn.new(@squares[row][i], white)
    end
  end
end

b = Board.new
b.display