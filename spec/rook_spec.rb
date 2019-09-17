require 'rook.rb'

RSpec.describe Rook do
  describe '#move_valid?(new_square)' do
    it 'Return true if the rook can move from 0,0 to 0,5' do
      square_start = instance_double('Square', position: { x: 0, y: 0 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 0, y: 5 })
      rook = Rook.new(square_start)
      expect(rook.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the rook can move from 0,0 to 5,0' do
      square_start = instance_double('Square', position: { x: 0, y: 0 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 0 })
      rook = Rook.new(square_start)
      expect(rook.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the rook can move from 1,1 to 1,0' do
      square_start = instance_double('Square', position: { x: 1, y: 1 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 1, y: 0 })
      rook = Rook.new(square_start)
      expect(rook.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the rook can move from 1,1 to 0,1' do
      square_start = instance_double('Square', position: { x: 1, y: 1 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 0, y: 1 })
      rook = Rook.new(square_start)
      expect(rook.move_valid?(square_end)).to eql(true)
    end

    it "Return false if the rook can't move from 0,0 to 5,5" do
      square_start = instance_double('Square', position: { x: 0, y: 0 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 5 })
      rook = Rook.new(square_start)
      expect(rook.move_valid?(square_end)).to eql(false)
    end

    it "Return false if the rook can't move from 0,0 to 5,4" do
      square_start = instance_double('Square', position: { x: 0, y: 0 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 4 })
      rook = Rook.new(square_start)
      expect(rook.move_valid?(square_end)).to eql(false)
    end
  end

  describe "#move(new_square)" do
    it "Moves the rook from 0,0 to 0,5 and sets @castling to false" do
      square_start = instance_double('Square', position: { x: 0, y: 0 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 0, y: 5 })
      allow(square_end).to receive(:occupy).and_return(nil)
      rook = Rook.new(square_start)
      expect(rook.move(square_end)).to eql(nil)
      expect(rook.castling).to eql(false)
      expect(rook.square.position).to eql({ x: 0, y: 5 })
    end
  end
end