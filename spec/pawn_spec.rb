require 'pawn.rb'

RSpec.describe Pawn do
  describe '#move(new_square)' do
    it "Returns nil if the 0,0 square isn't occupied and moves the pawn to that square" do
      square_start = instance_double('Square', position: { x: 0, y: 0 }, piece: nil, white: true)
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 0, y: 1 }, piece: nil, white: true)
      allow(square_end).to receive(:occupy).and_return(nil)
      pawn = Pawn.new(square_start)
      expect(pawn.move(square_end)).to eql(nil)
      expect(pawn.square.position).to eql({ x: 0, y: 1 })
      expect(pawn.opening_move).to eql(false)
    end
  end

  describe '#move_valid?(new_square)' do
    it 'Returns true if the white pawn can move from 0,0 to 0,1' do
      square = instance_double('Square', position: { x: 0, y: 0})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 0, y: 1})
      allow(new_square).to receive(:occupied?).and_return(false)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it 'Returns true if the white pawn can move from 2,2 to 2,3' do
      square = instance_double('Square', position: { x: 2, y: 2})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 2, y: 3})
      allow(new_square).to receive(:occupied?).and_return(false)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it 'Returns true if the black pawn can move from 2,2 to 2,1' do
      square = instance_double('Square', position: { x: 2, y: 2})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 2, y: 1})
      allow(new_square).to receive(:occupied?).and_return(false)
      pawn = Pawn.new(square, false)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it 'Returns true if the white pawn can move from 1,1 to 1,3 as an opening move' do
      square = instance_double('Square', position: { x: 1, y: 1})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 1, y: 3})
      allow(new_square).to receive(:occupied?).and_return(false)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it 'Returns true if the black pawn can move from 3,3 to 3,1 as an opening move' do
      square = instance_double('Square', position: { x: 3, y: 3})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 3, y: 1})
      allow(new_square).to receive(:occupied?).and_return(false)
      pawn = Pawn.new(square, false)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it 'Returns true if the white pawn can move from 2,2 to 3,3 and eat a black piece' do
      square = instance_double('Square', position: { x: 2, y: 2})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 3, y: 3})
      allow(new_square).to receive(:occupied?).and_return(true)
      allow(new_square).to receive(:occupied_by_different_color?).and_return(true)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it 'Returns true if the white pawn can move from 2,2 to 3,1 and eat a black piece' do
      square = instance_double('Square', position: { x: 2, y: 2})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 1, y: 3})
      allow(new_square).to receive(:occupied?).and_return(true)
      allow(new_square).to receive(:occupied_by_different_color?).and_return(true)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it 'Returns true if the black pawn can move from 2,2 to 3,1 and eat a white piece' do
      square = instance_double('Square', position: { x: 2, y: 2})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 3, y: 1})
      allow(new_square).to receive(:occupied?).and_return(true)
      allow(new_square).to receive(:occupied_by_different_color?).and_return(true)
      pawn = Pawn.new(square, false)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it 'Returns true if the black pawn can move from 2,2 to 1,1 and eat a white piece' do
      square = instance_double('Square', position: { x: 2, y: 2})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 1, y: 1})
      allow(new_square).to receive(:occupied?).and_return(true)
      allow(new_square).to receive(:occupied_by_different_color?).and_return(true)
      pawn = Pawn.new(square, false)
      expect(pawn.move_valid?(new_square)).to eql(true)
    end

    it "Returns false if the white pawn can't move from 0,0 to 0,1, because 0,1 is occupied" do
      square = instance_double('Square', position: { x: 0, y: 0})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 0, y: 1})
      allow(new_square).to receive(:occupied?).and_return(true)
      allow(new_square).to receive(:occupied_by_different_color?).and_return(false)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(false)
    end

    it "Returns false if the white pawn can't move from 0,0 to 0,3" do
      square = instance_double('Square', position: { x: 0, y: 0})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 0, y: 3})
      allow(new_square).to receive(:occupied?).and_return(false)
      allow(new_square).to receive(:occupied_by_different_color?).and_return(true)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(false)
    end

    it "Returns false if the white pawn can't move from 1,1 to 1,0" do
      square = instance_double('Square', position: { x: 0, y: 0})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 1, y: 0})
      allow(new_square).to receive(:occupied?).and_return(false)
      allow(new_square).to receive(:occupied_by_different_color?).and_return(true)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(false)
    end

    it "Returns false if the white pawn can't move from 0,0 to 1,1, because 1,1 isn't occupied" do
      square = instance_double('Square', position: { x: 0, y: 0})
      allow(square).to receive(:occupy).and_return(nil)
      new_square = instance_double('Square', position: {x: 1, y: 1})
      allow(new_square).to receive(:occupied?).and_return(false)
      allow(new_square).to receive(:occupied_by_different_color?).and_return(false)
      pawn = Pawn.new(square)
      expect(pawn.move_valid?(new_square)).to eql(false)
    end
  end
end