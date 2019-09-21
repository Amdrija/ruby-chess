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
    @eaten_pieces = []
  end

  def display
    system('clear')
    puts '   0  1  2  3  4  5  6  7'
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


    return false if square_start.piece.class != Pawn &&
                    square_start.piece.class != King &&
                    square_start.piece.class != Knight &&
                    blocks?(square_start, square_end)

    !future_check(square_start, square_end)
  end

  def move(square_start, square_end)
    # if it's the castling move
    if square_start.piece.class == King && (square_start.position[:x] - square_end.position[:x]).abs > 1
      position_y = square_start.position[:y]
      king_x = square_start.position[:x]

      horizontal_direction = square_end.position[:x] - king_x
      horizontal_direction = horizontal_direction.positive? ? 1 : -1
      rook_x = horizontal_direction.positive? ? 7 : 0
      rook = @squares[position_y][rook_x].piece

      rook.move(@squares[position_y][king_x + horizontal_direction])
    end

    eaten_piece = square_start.piece.move(square_end)
    @eaten_pieces << eaten_piece unless eaten_piece.nil?
  end

  def display_eaten_pieces
    string = ''
    @eaten_pieces.each do |piece|
      string += "#{piece}, "
    end
    puts string
  end


  def castling?(square_start, square_end)
    return false if square_start.position[:y] != square_end.position[:y]
    return false if square_start.piece.class != King
    return false unless square_start.piece.castling

    position_y = square_start.position[:y]
    king_x = square_start.position[:x]

    horizontal_direction = square_end.position[:x] - king_x
    rook_x = horizontal_direction.positive? ? 7 : 0

    return false if @squares[position_y][rook_x].piece.class != Rook

    rook = @squares[position_y][rook_x].piece
    return false unless rook.castling

    king = square_start.piece
    ((king.square.position[:x] - rook_x).abs - 1).times do |x|
      return false if @squares[position_y][king_x + horizontal_direction].occupied? ||
                      (x < 2 && @squares[position_y][king_x + horizontal_direction].checked)
    end
    true
  end

  def parse_board_for_check(white)
    reset_square_checks
    pieces = white ? @white_pieces : @black_pieces
    pieces.each do |piece|
      piece.check(@squares)
    end
  end

  def check?(white)
    king = find_king(white)
    king.square.checked
  end

  def checkmate?(white)
    check?(white) && stalemate?(white)
  end

  def stalemate?(white)
    pieces = white ? @white_pieces : @black_pieces
    @squares.each do |row|
      row.each do |square|
        pieces.each do |piece|
          return false if move_valid?(piece.square, square)
        end
      end
    end
    true
  end

  def pawn_promotion(white)
    last_row = white ? 7 : 0
    pieces = white ? @white_pieces : @black_pieces
    pawns = pieces.filter {|piece| piece.class == Pawn}
    pawns.each do |pawn|
      next unless pawn.square.position[:y] == last_row

      case promotion_letter
      when 'Q'
        pieces << Queen.new(pawn.square, white)
      when 'K'
        pieces << Knight.new(pawn.square, white)
      when 'B'
        pieces << Bishop.new(pawn.square, white)
      when 'R'
        pieces << Rook.new(pawn.square, white)
      else
        puts 'Error, you can only promote to a Queen, Rook, Bishop or Knight'
      end
    end
  end

  private

  def promotion_letter
    puts 'You can promote the pawn to a queen, knight, bishop or rook.'
    puts 'Type Q for Queen, K for Knight, B for Bishop or R for Rook.'
    letter = gets.chomp.upcase
    while letter.length != 1 && !letter.match?(/[QKBR]/)
      letter = gets.chomp.upcase
    end
    letter
  end

  def remove_piece(piece)
    return nil if piece.nil?

    pieces = piece.white ? @white_pieces : @black_pieces
    pieces.delete(piece)
  end

  def add_piece(piece)
    pieces = piece.white ? @white_pieces : @black_pieces
    pieces.push(piece)
  end

  def future_check(square_start, square_end)
    end_piece = square_end.piece
    piece = square_start.piece
    piece.move(square_end)
    remove_piece(end_piece)
    parse_board_for_check(!piece.white)
    future_check = check?(piece.white)
    piece.move(square_start)

    unless end_piece.nil?
      add_piece(end_piece)
      end_piece.square = square_end
      square_end.piece = end_piece
    end

    future_check
  end

  def find_king(white)
    pieces = white ? @white_pieces : @black_pieces
    pieces.find {|piece| piece.class == King}
  end

  def reset_square_checks
    squares.each do |row|
      row.each do |square|
        square.checked = false
      end
    end
  end

  def blocks?(square_start, square_end)
    horizontal_step, vertical_step = *direction(square_start, square_end)

    return sub_diagonal_blocks?(square_start, square_end) if vertical_step == -1

    position_y = square_end.position[:y]
    position_x = square_end.position[:x]

    eating_end_square_piece = true
    while position_y <= square_start.position[:y] && position_x <= square_start.position[:x] &&
          !(position_y == square_start.position[:y] && position_x == square_start.position[:x])

      if @squares[position_y][position_x].occupied?
        return true if @squares[position_y][position_x].piece.white == square_start.piece.white

        return true unless eating_end_square_piece

      end

      eating_end_square_piece = false
      position_x += horizontal_step
      position_y += vertical_step
    end

    while position_y >= square_start.position[:y] && position_x >= square_start.position[:x] &&
          !(position_y == square_start.position[:y] && position_x == square_start.position[:x])

      if @squares[position_y][position_x].occupied?
        return true if @squares[position_y][position_x].piece.white == square_start.piece.white

        return true unless eating_end_square_piece

      end

      eating_end_square_piece = false
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

    eating_end_square_piece = true
    while position_y < square_start.position[:y] && position_x > square_start.position[:x]
      if @squares[position_y][position_x].occupied?
        return true if @squares[position_y][position_x].piece.white == square_start.piece.white

        return true unless eating_end_square_piece

      end

      eating_end_square_piece = false
      position_x -= 1
      position_y += 1
    end

    while position_y > square_start.position[:y] && position_x < square_start.position[:x]
      if @squares[position_y][position_x].occupied?
        return true if @squares[position_y][position_x].piece.white == square_start.piece.white

        return true unless eating_end_square_piece

      end

      eating_end_square_piece = false
      position_x += 1
      position_y -= 1
    end

    false
  end

  # if the coordinates of square is x, y, then we access that square with squares[y][x]
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
