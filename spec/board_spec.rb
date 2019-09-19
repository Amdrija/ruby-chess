require 'board.rb'

RSpec.describe Board do
  describe "#parse_board_for_check(white)" do
    it "Sets all square's :checked that are attacked on the opening turn to true" do
      board = Board.new
      board.parse_board_for_check(true)


      3.times do |y|
        8.times do |x|
          #nobody is attacking the squares with white rooks at the opening turn
          if y == 0 && (x == 0 || x == 7)
            expect(board.squares[y][x].checked).to eql(false)
          else
            expect(board.squares[y][x].checked).to eql(true)
          end
        end
        puts
      end

      5.times do |y|
        8.times do |x|
          expect(board.squares[y + 3][x].checked).to eql(false)
        end
      end
    end
  end

  describe "#move_valid?(square_start, square_end)" do
    it "Returns true if Pawn can move from 0,1 to 0,2" do
      board = Board.new
      expect(board.move_valid?(board.squares[1][0], board.squares[2][0])).to eql(true)
    end

    it "Returns false if Bishop can't move from 2,0 to 3,1" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][2], board.squares[1][3])).to eql(false)
    end

    it "Returns false if Bishop can't move from 2,0 to 5,3" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][2], board.squares[3][5])).to eql(false)
    end

    it "Returns false if Bishop can't move from 2,0 to 0,2" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][2], board.squares[2][0])).to eql(false)
    end

    it "Returns false if Rook can't move from 0,0 to 0,3" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][0], board.squares[3][0])).to eql(false)
    end

    it "Returns false if Rook can't move from 0,0 to 3,0" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][0], board.squares[0][3])).to eql(false)
    end

    it "Return true if Knight can move from 1,0 to 0,2" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][1], board.squares[2][0])).to eql(true)
    end
  end
end