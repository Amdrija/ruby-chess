require 'square.rb'

RSpec.describe Square do
  describe 'occupied_by_same_color?(piece)' do
    it 'Returns true if the piece has the same color as the piece on the square' do
      new_piece = instance_double('ChessPiece', white: true)
      square_piece = instance_double('ChessPiece', white: true)
      square = Square.new({ x: 0, y: 0 }, square_piece)
      expect(square.occupied_by_same_color?(new_piece)).to eql(true)
    end

    it "Returns false if the piece doesn't have the same color as the piece on the square" do
      new_piece = instance_double('ChessPiece', white: true)
      square_piece = instance_double('ChessPiece', white: false)
      square = Square.new({ x: 0, y: 0 }, square_piece)
      expect(square.occupied_by_same_color?(new_piece)).to eql(false)
    end

    it "Returns false if the square isn't occupied" do
      new_piece = instance_double('ChessPiece', white: true)
      square = Square.new({ x: 0, y: 0 })
      expect(square.occupied_by_same_color?(new_piece)).to eql(false)
    end
  end

  describe 'occupied_by_different_color?(piece)' do
    it 'Returns true if the piece doesn\'t have the same color as the piece on the square' do
      new_piece = instance_double('ChessPiece', white: true)
      square_piece = instance_double('ChessPiece', white: false)
      square = Square.new({ x: 0, y: 0 }, square_piece)
      expect(square.occupied_by_different_color?(new_piece)).to eql(true)
    end

    it "Returns false if the piece has the same color as the piece on the square" do
      new_piece = instance_double('ChessPiece', white: true)
      square_piece = instance_double('ChessPiece', white: true)
      square = Square.new({ x: 0, y: 0 }, square_piece)
      expect(square.occupied_by_different_color?(new_piece)).to eql(false)
    end

    it "Returns false if the square isn't occupied" do
      new_piece = instance_double('ChessPiece', white: true)
      square = Square.new({ x: 0, y: 0 })
      expect(square.occupied_by_different_color?(new_piece)).to eql(false)
    end
  end

  describe 'occupy(piece)' do
    it 'Occupies the square 0,0 by the given piece' do
      piece = instance_double('ChessPiece', white: true)
      square = Square.new
      square.occupy(piece)
      expect(square.piece).to eql(piece)
    end

    it 'Occupies the square 2,3 by the given piece' do
      piece = instance_double('ChessPiece', white: true)
      square = Square.new({ x: 2, y: 3 })
      square.occupy(piece)
      expect(square.piece).to eql(piece)
    end

    it "Returns nil if the square wasn't occupied beforehand" do
      piece = instance_double('ChessPiece', white: true)
      square = Square.new({ x: 2, y: 3 })
      expect(square.occupy(piece)).to eql(nil)
    end

    it 'Returns eaten_piece if the square was occupied beforehand' do
      piece = instance_double('ChessPiece', white: true)
      eaten_piece = instance_double('ChessPiece', white: false)
      square = Square.new({ x: 2, y: 3}, eaten_piece)
      expect(square.occupy(piece)).to eql(eaten_piece)
    end
  end
end