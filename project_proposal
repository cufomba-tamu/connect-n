Project 1 Proposal
* Team 2 members
   * Michael Zhou
   * Chibuzo Ufomba


* App name
   * The name of our project is Connect N game
   * App description
* It is an easy strategy game, where two players compete to connect 4 or more pieces on a board.
* The pieces are connected vertically, horizontally and diagonally.
* The columns on the board are numbered 1 to 6, and the user picks which column they want to drop the piece in.
* The board fills with pieces from the bottom to the top
* The first player to connect 4 pieces together wins the game
* For the purpose of our game, our pieces are letters, for example: “R” for Red and “B” for Blue.

   * Intended user
   * Two people who want a quick strategy game in the terminal, with the option to make it harder or easier by changing the board size and win length.
   * Core features
   * Two-player alternating turns: a player picks a column and the piece falls to the lowest empty row.
   * Configurable board dimensions and win length, chosen at the start of a game.
   * Players can choose their colors from a set of predetermined 6 colors.
   * Win detection for a run of k in any direction (horizontal, vertical, diagonal), plus draw detection when the board fills
   * Input validation and error handling (non-numeric input, out-of-range column, full column, quit command)
   * Persistent scoreboard saved to a file so win tallies survive between sessions
   * Stretch features
   * Undo the previous move
   * Quit the game
   * Colored terminal output to distinguish the two players' pieces




   * Main classes/modules
   * Board - holds the grid, drops pieces with gravity, detects wins and draws, and renders the board to the terminal
   * Game - the main controller: shows the menu, runs the turn loop, alternates players, and handles the end of each round
   * ScoreBoard - Keeps track of which player is winning the series, for example, best of 5 series


   * Test cases
   * Gravity/drop: Start with an empty board, drop a piece in column 3, expect it to land in the bottom row of column 3.
   * Configurable board: Request a board whose win length can't fit (e.g. a 5×5 board with win length 6), expect it to be rejected with an error message.
   * Win detection: Start with three of Player X's pieces in a horizontal row and a win length of 4, place a fourth beside them, expect X to be declared the winner.
   * Input validation: Start with a full column, attempt to drop a piece there, expect the app to reject it and re-prompt rather than place the piece.
   * Scoreboard persistence: Record a win for X, reload the scoreboard from file, expect X's tally to read 1.