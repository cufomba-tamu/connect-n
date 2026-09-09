# User Stories

## 1. Drop a piece (essential) — 3 points

**As a** player, **I want to** drop a piece into a column **so that** I
can take my turn.

**Acceptance criteria:**
- The piece lands in the lowest currently-empty row of the chosen column.
- Dropping into a column that's already full is rejected, not silently
  ignored or crashed.
- The board is re-rendered after every successful move so the state is
  always visible.