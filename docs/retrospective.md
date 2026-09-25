# Retrospective

This is an interim retrospective, written partway through the project
rather than at the very end — sections below get filled in as we
discuss them.

## What Went Well

- **Clean component split.** Chibuzo on `Game`/`Player`, Michael on
  `Board`, which let us both work in parallel without much overlap or
  blocking each other.
- **Consistent test discipline.** Almost every story shipped with both
  happy-path and sad-path specs (invalid input, full columns, "one
  piece short of a win," etc.), not just tests for show.
- **Willingness to redesign mid-project.** The board-configuration
  story got reworked (asking only for win length instead of rows/
  columns separately) once we realized the simpler design was clearly
  better, instead of just pushing forward with the first idea.
- **Good architectural discipline early on.** The `input:`/`output:`
  dependency-injection pattern got established in the very first
  session and stayed consistent through every later `Game` method.
- **Catching real bugs through review, not luck.** Reading through
  each other's code surfaced the win-length hardcoding and the
  Scoreboard persistence/keying gaps directly, and the follow-up work
  got split cleanly afterward.
- **Went beyond the minimum.** Alongside the essential stories, we
  also built out the stretch goal (computer opponent) rather than
  treating it as optional filler.
- **Steady, incremental progress.** Several stories moved from
  not-started to done/in-progress in quick succession (win detection,
  draw detection, the win/draw game loop, computer opponent) rather
  than one big last-minute push.
- **Good communication.** We've been able to meet consistently to
  discuss things, rather than drifting out of sync between sessions.

## What Was Difficult

- **Implementing win detection logic.** Implementing the win detection logic was 
 the most difficult part of our project because we had to make it work for different board size
and different win length. We had to check all possible win directions ie, horizontal, vertical and 
 both diagonal directions. We used loops and grid indexing to make sure we were not going over the
 board/grid size
- 
## What We'd Do Differently

**Spend more time planning** What we would differently if we were to start over is to
 spend more time during the initial planning of the development. 
- This would give us a proper structure to follow, and we would not have to make some significant changes during the 
 development, eg hardcoding the gameboard dimensions to a 6x7 board size, we later changed this to 
 a configurable board size that depend on the win length selected. 
- This would have helped us
 to define the project requirements more clearly.

## Is the App Meeting Our Original Goal?

- **Yes, the App meets our original goal**
 Our goal was to develop a terminal app, ie a Connect Four(N) game 
 for friends to play together for  fun. A user can also play against a computer. 
 We achieved our goal as both of these objectives were met.
