require 'chess_piece.rb'

RSpec.describe ChessPiece do
  describe '#move(square)' do
    it 'Moves the piece from 0,0 to 7,0' do
      square_start = Square.new({ x: 0, y: 0 })
      square_end = instance_double('Square', position: { x: 7, y: 0 }, piece: nil, white: true)
      allow(square_end).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square_start)
      piece.move(square_end)
      expect(piece.square.position).to eql({ x: 7, y: 0 })
      expect(square_start.piece).to eql(nil)
    end

    it 'Moves the piece from 1,4 to 6,1' do
      square_start = Square.new({ x: 1, y: 4 })
      square_end = instance_double('Square', position: { x: 6, y: 1 }, piece: nil, white: true)
      allow(square_end).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square_start)
      piece.move(square_end)
      expect(piece.square.position).to eql({ x: 6, y: 1 })
      expect(square_start.piece).to eql(nil)
    end
  end

  describe '#horizontal_move?(y)' do
    it 'Returns true when a chess piece on 0,0 can move to 7,0' do
      square = instance_double('Square', position: { x: 0, y: 0 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.horizontal_move?(0)).to eql(true)
    end

    it 'Returns true when a chess piece on 2,3 can move to 5,3' do
      square = instance_double('Square', position: { x: 2, y: 3 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.horizontal_move?(3)).to eql(true)
    end

    it 'Returns false when a chess piece on 2,3 can\'t move to 5,4' do
      square = instance_double('Square', position: { x: 2, y: 3 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.horizontal_move?(4)).to eql(false)
    end
  end

  describe '#vertical_move?(x, y)' do
    it 'Returns true when a chess piece on 0,0 can move to 0,5' do
      square = instance_double('Square', position: { x: 0, y: 0 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.vertical_move?(0)).to eql(true)
    end

    it 'Returns true when a chess piece on 2,3 can move to 2,2' do
      square = instance_double('Square', position: { x: 2, y: 3 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.vertical_move?(2)).to eql(true)
    end

    it 'Returns false when a chess piece on 7,3 can\'t to 3,4' do
      square = instance_double('Square', position: { x: 7, y: 3 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.vertical_move?(3)).to eql(false)
    end
  end

  describe '#diagonal_move?(x, y)' do
    it 'Returns true when a chess piece on 0,0 can move to 3,3' do
      square = instance_double('Square', position: { x: 0, y: 0 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.diagonal_move?(3, 3)).to eql(true)
    end

    it 'Returns true when a chess piece on 4,5 can move to 3,6' do
      square = instance_double('Square', position: { x: 4, y: 5 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.diagonal_move?(3, 6)).to eql(true)
    end

    it 'Returns true when a chess piece on 4,5 can move to 5,6' do
      square = instance_double('Square', position: { x: 4, y: 5 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.diagonal_move?(5, 6)).to eql(true)
    end

    it 'Returns true when a chess piece on 4,5 can move to 5,4' do
      square = instance_double('Square', position: { x: 4, y: 5 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.diagonal_move?(5, 4)).to eql(true)
    end

    it 'Returns true when a chess piece on 4,5 can move to 3,4' do
      square = instance_double('Square', position: { x: 4, y: 5 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.diagonal_move?(3, 4)).to eql(true)
    end

    it 'Returns false when a chess piece on 7,3 can\'t move to 3,4' do
      square = instance_double('Square', position: { x: 7, y: 3 })
      allow(square).to receive(:occupy).and_return(nil)
      piece = ChessPiece.new(square)
      expect(piece.diagonal_move?(3, 4)).to eql(false)
    end
  end
end