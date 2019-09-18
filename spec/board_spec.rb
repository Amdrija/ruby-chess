require 'board.rb'

RSpec.describe Board do
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