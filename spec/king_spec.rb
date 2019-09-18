require 'king.rb'

RSpec.describe King do
  describe "#move(new_square)" do
    it "Moves the rook from 0,0 to 0,1 and sets @castling to false" do
      square_start = Square.new({ x: 0, y: 0 })
      square_end = instance_double('Square', position: { x: 0, y: 1 })
      allow(square_end).to receive(:occupy).and_return(nil)
      king = King.new(square_start)
      expect(king.move(square_end)).to eql(nil)
      expect(king.castling).to eql(false)
      expect(king.square.position).to eql({ x: 0, y: 1 })
      expect(square_start.piece).to eql(nil)
    end
  end

  describe "#move_valid?(new_square)" do
    it 'Return true if the king can move from 4,4 to 4,5' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 4, y: 5 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 5,5' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 5 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 5,4' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 4 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 5,3' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 3 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 4,3' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 4, y: 3 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 3,3' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 3, y: 3 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 3,4' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 3, y: 4 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 3,5' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 3, y: 5 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 6,5' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 6, y: 5 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(false)
    end

    it 'Return true if the king can move from 4,4 to 2,4' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 2, y: 4 })
      allow(square_end).to receive(:check).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(false)
    end
  end
end