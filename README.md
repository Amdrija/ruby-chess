# Ruby Chess

Console implementation of chess in Ruby.

## How to play
First, you need to install [colorize gem](https://rubygems.org/gems/colorize/versions/0.8.1)
Secondly, clone or download this repo, open terminal and cd to the main directory of the game on your computer.
Afterwards just type:  

    ruby lib/game.rb
in terminal.
## Features
You play by typing in the field of the chess piece you want to move and where you want to move it.
I am yet to implement game save and game load feature and the en_passant move.
## Castling
There is also castling, you do it by typing in the position of your king and typing in the square where the king finishes
after castling, for example: white king is on A4 and after castling with the rook on A7 it ends up on A6, so you type
in A4 to choose the white king and A6 is where the king ends up.
