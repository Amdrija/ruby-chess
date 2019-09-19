require 'queen.rb'

RSpec.describe Queen do
  describe "#check(squares)" do
    it "Sets all square's :checked that are attacked by a bishop on 4,4 to true" do
      squares = []
      8.times do |i|
        squares.push([])
        8.times do |j|
          squares[i].push(Square.new({ x: j, y: i }))
        end
      end
      queen = Queen.new(squares[4][4], true)
      queen.check(squares)
      offsets = [[1, 0], [-1, -0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
      offsets.each do |offset|
        new_x = queen.square.position[:x] + offset[0]
        new_y = queen.square.position[:y] + offset[1]
        while queen.coordinates_valid?(new_x, new_y) && !squares[new_y][new_x].occupied?
          expect(squares[new_y][new_x].checked).to eql(true)
          new_x += offset[0]
          new_y += offset[1]
        end

        expect(squares[new_y][new_x].checked).to eql(true) if queen.coordinates_valid?(new_x, new_y)
      end
      expect(squares[4][4].checked).to eql(false)
    end

    it "Sets all square's :checked that are attacked by a bishop on 1,0 to true" do
      squares = []
      8.times do |i|
        squares.push([])
        8.times do |j|
          squares[i].push(Square.new({ x: j, y: i }))
        end
      end
      queen = Queen.new(squares[0][1], true)
      queen.check(squares)
      offsets = [[1, 0], [-1, -0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
      offsets.each do |offset|
        new_x = queen.square.position[:x] + offset[0]
        new_y = queen.square.position[:y] + offset[1]
        while queen.coordinates_valid?(new_x, new_y) && !squares[new_y][new_x].occupied?
          expect(squares[new_y][new_x].checked).to eql(true)
          new_x += offset[0]
          new_y += offset[1]
        end

        expect(squares[new_y][new_x].checked).to eql(true) if queen.coordinates_valid?(new_x, new_y)
      end
      expect(squares[4][4].checked).to eql(false)
    end
  end

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