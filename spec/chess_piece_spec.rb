require "chess_piece.rb"

RSpec.describe ChessPiece do
  describe "#horizontal_move?(x, y)" do
    it "Returns true when a chess piece on 0,0 moves to 7,0" do
      piece = ChessPiece.new
      expect(piece.horizontal_move?(7, 0)).to eql(true)
    end

    it "Returns true when a chess piece on 2,3 moves to 5,3" do
      piece = ChessPiece.new("cp", {x: 2, y: 3})
      expect(piece.horizontal_move?(5, 3)).to eql(true)
    end

    it "Returns false when a chess piece on 2,3 moves to 5,4" do
      piece = ChessPiece.new("cp", {x: 2, y: 3})
      expect(piece.horizontal_move?(5, 4)).to eql(false)
    end
  end

  describe "#vertical_move?(x, y)" do
    it "Returns true when a chess piece on 0,0 moves to 0,5" do
      piece = ChessPiece.new
      expect(piece.vertical_move?(0, 5)).to eql(true)
    end

    it "Returns true when a chess piece on 2,3 moves to 2,2" do
      piece = ChessPiece.new("cp", {x: 2, y: 3})
      expect(piece.vertical_move?(2, 2)).to eql(true)
    end

    it "Returns false when a chess piece on 7,3 moves to 3,4" do
      piece = ChessPiece.new("cp", {x: 2, y: 3})
      expect(piece.vertical_move?(5, 4)).to eql(false)
    end
  end

  describe "#diagonal_move?(x, y)" do
    it "Returns true when a chess piece on 0,0 moves to 3,3" do
      piece = ChessPiece.new
      expect(piece.diagonal_move?(3, 3)).to eql(true)
    end

    it "Returns true when a chess piece on 4,5 moves to 3,6" do
      piece = ChessPiece.new("cp", {x: 4, y: 5})
      expect(piece.diagonal_move?(3, 6)).to eql(true)
    end

    it "Returns true when a chess piece on 4,5 moves to 5,6" do
      piece = ChessPiece.new("cp", {x: 4, y: 5})
      expect(piece.diagonal_move?(5, 6)).to eql(true)
    end

    it "Returns true when a chess piece on 4,5 moves to 5,4" do
      piece = ChessPiece.new("cp", {x: 5, y: 4})
      expect(piece.diagonal_move?(3, 6)).to eql(true)
    end

    it "Returns true when a chess piece on 4,5 moves to 3,4" do
      piece = ChessPiece.new("cp", {x: 4, y: 5})
      expect(piece.diagonal_move?(3, 4)).to eql(true)
    end

    it "Returns false when a chess piece on 7,3 moves to 3,4" do
      piece = ChessPiece.new("cp", {x: 7, y: 3})
      expect(piece.diagonal_move?(3, 4)).to eql(false)
    end
  end
end