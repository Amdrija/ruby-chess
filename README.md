# Ruby Chess

Console implementation of chess in Ruby.

## How to play
First, you need to install [colorize gem](https://rubygems.org/gems/colorize/versions/0.8.1)
Secondly, clone or download this repo, open terminal and cd to the main directory of the game on your computer.
Afterwards just type:  

    ruby lib/game.rb
in terminal.

## Repl.it
There is an online version as well. It is hosted on Repl.it on this [link](https://repl.it/@Amdrija/RubyChess), however, the chessboard isn't even because of the limitation of printing unicode characters in Repl.it console. To fix this you could try modifying the CSS properties in your browsers developer tools, but I still haven't found settings that could help with this.
## Features
Here is an example of the board:

![](res/Screen&#32;Shot&#32;2019-11-15&#32;at&#32;14.50.23.png)

You play by typing in the field of the chess piece you want to move and where you want to move it.
Here is an example:

![](res/Screen&#32;Shot&#32;2019-11-15&#32;at&#32;14.53.54.png)

After typing in these coordinates, the board looks like this:

![](res/Screen&#32;Shot&#32;2019-11-15&#32;at&#32;14.54.15.png)

I am yet to implement game save and game load feature and the en_passant move.
## Castling
There is also castling, you do it by typing in the position of your king and typing in the square where the king finishes
after castling, for example: white king is on A4 and after castling with the rook on A7 it ends up on A6, so you type
in A4 to choose the white king and A6 is where the king ends up.
