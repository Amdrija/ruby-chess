require 'bishop.rb'

RSpec.describe Bishop do
  describe "#check(squares)" do
    it "Sets all square's :checked that are attacked by a bishop on 4,4 to true" do
      squares = []
      8.times do |i|
        squares.push([])
        8.times do |j|
          squares[i].push(Square.new({ x: j, y: i }))
        end
      end
      bishop = Bishop.new(squares[4][4], true)
      bishop.check(squares)
      offsets = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
      offsets.each do |offset|
        new_x = bishop.square.position[:x] + offset[0]
        new_y = bishop.square.position[:y] + offset[1]
        while bishop.coordinates_valid?(new_x, new_y) && !squares[new_y][new_x].occupied?
          expect(squares[new_y][new_x].checked).to eql(true)
          new_x += offset[0]
          new_y += offset[1]
        end

        expect(squares[new_y][new_x].checked).to eql(true) if bishop.coordinates_valid?(new_x, new_y)
      end
      expect(squares[4][4].checked).to eql(false)
    end
  end
end