# WebChess #

Demo can be found here, under the moniker Quick Chess:

quickchess.herokuapp.com

## Features ##

Create a chess game quickly. Send a link to a friend/bitter enemy. Play in real time.

## How it Works ##

### Frontend ###

Game board is built almost entirely in Coffeescript. Ajax polling is used to know when the board has been updated. Attempting a move triggers an Ajax put to modify the game model object. If it was a successful request, client updates board. Unsuccesful moves receive a response from the server with a message that describe what went wrong. This message is repeated to the user.

### Backend ###

Backend is in rails. When a new game is created, the database object self instantiates a new Chess::game object. This object is then YAML'd and saved as text in the database. When a move is made, the server loads the YAML for that particular game, and uses the Chess::game move function to execute the move. If successful, the game is re-YAML'd and saved into the database. If not successful, errors are raised that are interepreted by the controller as Http responses.