require './lib/bishop.rb'
require './lib/king.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/queen.rb'
require './lib/rook.rb'
require './lib/square.rb'
require 'colorize'

class Board
  attr_reader :squares
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

  private

  def reset_board
    @squares = []
    8.times do |i|
      @squares.push([])
      8.times do |j|
        square = Square.new({ x: i, y: j}, nil, (i + j).even?)
        @squares[i].push(square)
      end
    end
  end

  def reset_pieces(white)
    reset_pawns(white)
    row = white ? 0 : 7

    Rook.new(@squares[row][0], white)
    Rook.new(@squares[row][7], white)

    Knight.new(@squares[row][1], white)
    Knight.new(@squares[row][6], white)

    Bishop.new(@squares[row][2], white)
    Bishop.new(@squares[row][5], white)

    Queen.new(@squares[row][3], white)
    King.new(@squares[row][4], white)
  end

  def reset_pawns(white)
    row = white ? 1 : 6
    8.times do |i|
      Pawn.new(@squares[row][i], white)
    end
  end
end

b = Board.new
b.display