require 'board.rb'

RSpec.describe Board do
  describe "#parse_board_for_check(white)" do
    it "Sets all square's :checked that are attacked on the opening turn to true" do
      board = Board.new
      board.parse_board_for_check(true)
      3.times do |y|
        8.times do |x|
          #nobody is attacking the squares with white rooks at the opening turn
          if y == 0 && (x == 0 || x == 7)
            expect(board.squares[y][x].checked).to eql(false)
          else
            expect(board.squares[y][x].checked).to eql(true)
          end
        end
        puts
      end

      5.times do |y|
        8.times do |x|
          expect(board.squares[y + 3][x].checked).to eql(false)
        end
      end
    end
  end

  describe "#move_valid?(square_start, square_end)" do
    it "Returns true if Pawn can move from 0,1 to 0,2" do
      board = Board.new
      expect(board.move_valid?(board.squares[1][0], board.squares[2][0])).to eql(true)
    end

    it "Returns false if Bishop can't move from 2,0 to 3,1" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][2], board.squares[1][3])).to eql(false)
    end

    it "Returns false if Bishop can't move from 2,0 to 5,3" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][2], board.squares[3][5])).to eql(false)
    end

    it "Returns false if Bishop can't move from 2,0 to 0,2" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][2], board.squares[2][0])).to eql(false)
    end

    it "Returns false if Rook can't move from 0,0 to 0,3" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][0], board.squares[3][0])).to eql(false)
    end

    it "Returns false if Rook can't move from 0,0 to 3,0" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][0], board.squares[0][3])).to eql(false)
    end

    it "Return true if Knight can move from 1,0 to 0,2" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][1], board.squares[2][0])).to eql(true)
    end

    it "Return false if white Bishop can't move from 4,1 to 3,2 due to it protecting king from check" do
      board = Board.new
      board.squares[7][0].piece.move(board.squares[4][4]) #black rook from h0 to e4
      board.squares[1][4].piece.move(board.squares[3][3]) #white pawn from b4 to d4
      board.squares[0][5].piece.move(board.squares[1][4]) #white bishop from a5 to b4
      #board.display
      expect(board.move_valid?(board.squares[1][4], board.squares[2][3])).to eql(false)
    end

    it "Return true if white Rook can move from 4,1 to 4,4" do
      board = Board.new
      board.squares[7][0].piece.move(board.squares[4][4]) #black rook from h0 to e4
      board.squares[1][4].piece.move(board.squares[3][3]) #white pawn from b4 to d4
      board.squares[0][0].piece.move(board.squares[1][4]) #white rook from a0 to e4
      #board.display
      expect(board.move_valid?(board.squares[1][4], board.squares[4][4])).to eql(true)
    end

    it "Return false if King can't move from 4,0 to 3,1" do
      board = Board.new
      expect(board.move_valid?(board.squares[0][4], board.squares[1][3])).to eql(false)
    end
  end

  describe "#stalemate?(white)" do
    it "Return false if there isn't stalemate on opening move" do
      board = Board.new
      expect(board.stalemate?(true)).to eql(false)
    end

    it "Return true if there is stalemate" do
      board = Board.new
      board.squares[1][3].piece.move(board.squares[2][3])
      board.squares[0][3].piece.move(board.squares[2][7])
      board.squares[7][5].piece.move(board.squares[4][0])
      board.squares[1][2].piece.move(board.squares[3][2])
      board.squares[1][1].piece.move(board.squares[5][1])
      board.squares[0][2].piece.move(board.squares[0][3])
      board.squares[0][1].piece.move(board.squares[5][1])
      expect(board.stalemate?(true)).to eql(true)
    end

    it "Return false if there is stalemate, the horse on 1, 2 can eat the bishop on 4, 0" do
      board = Board.new
      board.squares[1][3].piece.move(board.squares[2][3])
      board.squares[0][3].piece.move(board.squares[2][7])
      board.squares[7][5].piece.move(board.squares[4][0])
      board.squares[1][2].piece.move(board.squares[3][2])
      board.squares[1][1].piece.move(board.squares[5][1])
      board.squares[0][2].piece.move(board.squares[0][3])
      board.squares[0][1].piece.move(board.squares[2][1])
      expect(board.stalemate?(true)).to eql(false)
    end
  end

  describe "#checkmate?(white)" do
    it "Return false if there isn't checkmate on opening move" do
      board = Board.new
      expect(board.checkmate?(true)).to eql(false)
    end

    it "Return true if there is checkmate" do
      board = Board.new
      board.squares[1][3].piece.move(board.squares[2][3])
      board.squares[0][3].piece.move(board.squares[2][7])
      board.squares[7][5].piece.move(board.squares[4][0])
      board.squares[1][2].piece.move(board.squares[3][2])
      board.squares[1][1].piece.move(board.squares[5][1])
      board.squares[0][2].piece.move(board.squares[0][3])
      board.squares[0][1].piece.move(board.squares[5][1])
      board.parse_board_for_check(false)
      expect(board.checkmate?(true)).to eql(true)
    end

    it "Return false if there is check but not checkmate" do
      board = Board.new
      board.squares[1][3].piece.move(board.squares[2][3])
      board.squares[7][5].piece.move(board.squares[4][0])
      board.parse_board_for_check(false)
      expect(board.checkmate?(true)).to eql(false)
    end
  end

  describe "#pawn_promotion(white)" do
    it "Promotes the white pawn that is on the last row to a queen" do
      board = Board.new
      board.squares[1][0].piece.move(board.squares[7][0])
      allow_any_instance_of(Object).to receive(:gets).and_return "q\n"
      board.pawn_promotion(true)
      expect(board.squares[7][0].piece.class).to eql(Queen)
    end

    it "Promotes the black pawn that is on the last row to a knight" do
      board = Board.new
      board.squares[6][0].piece.move(board.squares[0][0])
      allow_any_instance_of(Object).to receive(:gets).and_return "k\n"
      board.pawn_promotion(false)
      expect(board.squares[0][0].piece.class).to eql(Knight)
    end

    it "Promotes the white pawn that is on the last row to a bishop" do
      board = Board.new
      board.squares[1][3].piece.move(board.squares[7][1])
      allow_any_instance_of(Object).to receive(:gets).and_return "B\n"
      board.pawn_promotion(true)
      expect(board.squares[7][1].piece.class).to eql(Bishop)
    end

    it "Promotes the black pawn that is on the last row to a rook" do
      board = Board.new
      board.squares[1][3].piece.move(board.squares[7][1])
      allow_any_instance_of(Object).to receive(:gets).and_return "r\n"
      board.pawn_promotion(true)
      expect(board.squares[7][1].piece.class).to eql(Rook)
    end

    it "Doesn't promote any pawns at the opening turn" do
      board = Board.new
      allow_any_instance_of(Object).to receive(:gets).and_return "r\n"
      board.pawn_promotion(true)
      8. times do |i|
        expect(board.squares[1][i].piece.class).to eql(Pawn)
      end
    end
  end
end