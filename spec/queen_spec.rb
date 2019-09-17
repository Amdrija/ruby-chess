require 'queen.rb'

RSpec.describe Queen do
  describe "#move_valid?(new_square)" do
    it 'Return true if the queen can move from 4,4 to 4,7' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 4, y: 7 })
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the queen can move from 4,4 to 4,0' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 4, y: 0 })
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the queen can move from 4,4 to 7,4' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 7, y: 4 })
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the queen can move from 4,4 to 2,4' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 2, y: 4 })
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the queen can move from 4,4 to 7,7' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 7, y: 7 })
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the queen can move from 4,4 to 3,3' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 3, y: 3 })
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the queen can move from 4,4 to 2,6' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 2, y: 6 })
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the queen can move from 4,4 to 7,1' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 7, y: 1 })
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(true)
    end

    it 'Return false if the queen can\'t move from 4,4 to 7,2' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 7, y: 2})
      queen = Queen.new(square_start)
      expect(queen.move_valid?(square_end)).to eql(false)
    end
  end
end