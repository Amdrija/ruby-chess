require 'knight.rb'

RSpec.describe Knight do
  describe "#move_valid?(new_square)" do
    it "Returns true if the knight can move from 4,4 to 6, 3" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 6, y: 3})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(true)
    end

    it "Returns true if the knight can move from 4,4 to 5, 2" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 5, y: 2})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(true)
    end

    it "Returns true if the knight can move from 4,4 to 3, 2" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 3, y: 2})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(true)
    end

    it "Returns true if the knight can move from 4,4 to 2, 3" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 2, y: 3})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(true)
    end

    it "Returns true if the knight can move from 4,4 to 2, 5" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 2, y: 5})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(true)
    end

    it "Returns true if the knight can move from 4,4 to 3, 6" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 3, y: 6})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(true)
    end

    it "Returns true if the knight can move from 4,4 to 5, 6" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 5, y: 6})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(true)
    end

    it "Returns false if the knight can't move from 4,4 to 5, 5" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 5, y: 5})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(false)
    end

    it "Returns false if the knight can't move from 4,4 to 5, 4" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 5, y: 4})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(false)
    end

    it "Returns false if the knight can't move from 4,4 to 4, 5" do
      square_start = instance_double("Square", position: { x: 4, y: 4})
      allow(square_start).to receive(:occupy).and_return(nil)
      square_end = instance_double("Square", position: { x: 4, y: 5})
      knight = Knight.new(square_start)
      expect(knight.move_valid?(square_end)).to eql(false)
    end
  end
end