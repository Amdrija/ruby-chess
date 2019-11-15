require './lib/board.rb'

class Game
  def initialize
    reset
  end

  def reset
    welcome_message

    if @board.nil?
      @board = Board.new
    else
      @board.reset
    end

    play
  end

  def welcome_message
    puts
    puts "Welcome to the Ruby Chess game."
    puts "White pieces have a white outline and aren't filled."
    puts "Black pieces have white color fill."
    puts "Enjoy your game!"
    puts "Press Enter key to continue."
    gets
  end

  def play
    white = true
    loop do
      check, stale_mate = *play_turn(white)
      if stale_mate
        @board.display
        if check
          checkmate_message(white)
          break
        end
        stale_mate_message
        break
      elsif check
        check_message(!white)
      end
      white = !white
    end
  end

  def play_turn(white)
    @board.display
    @board.display_eaten_pieces
    turn_message(white)


    square_start, square_end = *get_move(white)
    @board.move(square_start, square_end)

    @board.pawn_promotion(white)
    @board.parse_board_for_check(!white)
    # check the opposite player for stale_mate and check
    stale_mate = @board.stalemate?(!white)
    check = @board.check?(!white)
    [check, stale_mate]
  end

  def turn_message(white)
    player = white ? 'White' : 'Black'
    puts "#{player} player's turn."
  end

  def checkmate_message(white)
    player = white ? 'White' : 'Black'
    puts 'Checkmate'
    puts "#{player} player wins!"
  end

  def stale_mate_message
    puts 'Stalemate.'
    puts 'The game ends in a draw.'
  end

  def check_message(white)
    player = white ? 'White' : 'Black'
    puts "#{player} player is in check"
  end

  def get_move(white)
    puts 'Put the coordinated of the piece you want to move.'
    puts 'For example A4'
    coord = ''
    position_x = 0
    position_y = 0
    loop do
      coord = gets.chomp.upcase
      if coordinates_valid(coord)
        position_x, position_y = *chess_to_decart_coordinates(coord)
        if !@board.squares[position_y][position_x].piece.nil?
          break if @board.squares[position_y][position_x].piece.white == white

          puts "That piece isn't your color, try again."
        else
          puts 'That square is empty.'
        end
      else
        puts "Those coordinates don't exist, try again."
      end
    end

    square_start = @board.squares[position_y][position_x]
    puts 'Put the coordinates where you want to move the piece.'
    loop do
      coord = gets.chomp.upcase
      break if coordinates_valid(coord)

      puts "Those coordinates don't exist, try again."
    end

    position_x, position_y = *chess_to_decart_coordinates(coord)
    square_end = @board.squares[position_y][position_x]

    unless @board.castling?(square_start, square_end) || @board.move_valid?(square_start, square_end)
      puts 'That move is not possible, try again.'
      square_start, square_end = *get_move(white)
    end
    [square_start, square_end]
  end

  def coordinates_valid(coord)
    coord.match?(/^[A-H][0-7]$/)
  end

  def chess_to_decart_coordinates(chess_coordinates)
    [chess_coordinates[1].to_i, chess_coordinates[0].ord - 'A'.ord]
  end
end

Game.new