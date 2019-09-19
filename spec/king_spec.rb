require 'king.rb'

RSpec.describe King do
  describe "#check(squares)" do
    it "Sets all square's :checked that are attacked by a king on 1,0 to true" do
      squares = []
      8.times do |i|
        squares.push([])
        8.times do |j|
          squares[i].push(Square.new({ x: j, y: i }))
        end
      end
      king = King.new(squares[0][1], true)
      king.check(squares)
      offsets = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
      offsets.each do |offset|
        new_x = king.square.position[:x] + offset[0]
        new_y = king.square.position[:y] + offset[1]

        expect(squares[new_y][new_x].checked).to eql(true) if king.coordinates_valid?(new_x, new_y)
      end
      expect(squares[0][1].checked).to eql(false)
    end

    it "Sets all square's :checked that are attacked by a king on 4,4 to true" do
      squares = []
      8.times do |i|
        squares.push([])
        8.times do |j|
          squares[i].push(Square.new({ x: j, y: i }))
        end
      end
      king = King.new(squares[4][4], true)
      king.check(squares)
      offsets = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
      offsets.each do |offset|
        new_x = king.square.position[:x] + offset[0]
        new_y = king.square.position[:y] + offset[1]

        expect(squares[new_y][new_x].checked).to eql(true) if king.coordinates_valid?(new_x, new_y)
      end
      expect(squares[4][4].checked).to eql(false)
    end
  end
  
  describe "#move(new_square)" do
    it "Moves the king from 0,0 to 0,1 and sets @castling to false" do
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
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 5,5' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 5 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 5,4' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 4 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 5,3' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 5, y: 3 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 4,3' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 4, y: 3 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 3,3' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 3, y: 3 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 3,4' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 3, y: 4 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 3,5' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 3, y: 5 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(true)
    end

    it 'Return true if the king can move from 4,4 to 6,5' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 6, y: 5 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(false)
    end

    it 'Return true if the king can move from 4,4 to 2,4' do
      square_start = instance_double('Square', position: { x: 4, y: 4 })
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double('Square', position: { x: 2, y: 4 })
      allow(square_end).to receive(:checked).and_return(false)
      king = King.new(square_start)
      expect(king.move_valid?(square_end)).to eql(false)
    end
  end
end