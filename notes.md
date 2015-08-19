First session: 19:40-20:10

Boolean? State? Predicates?

Did you first design the whole thing or start at the top?


## Cells can be dead or alive

Do we need to be able to kill cells in order to test that they can be dead?

Design choices:
- We can make the cell immutable and pass in its state at creation time. This
  means killing a living cell is just replacing it with a dead one.
- We can keep track of the state inside the cell. This gives room for more
  logic and may simplify the updating process.
- How do we find out its state? Options are: a #state method, or state
  predicates. The latter are better from an encapsulation perspective.

If the cells are immutable we can return the same dead cell for each dead
location on the grid, and the same for live cells.

## Rectangular Grid

How do you test a rectangular grid? What are its properties?

Perhaps we can only test persistence after the cells gain distinguishing
characteristics. We could use object_id, but that is also a design choice: We
only need the grid to return the same value, and shouldn't really care if it's
the same object.

Vice versa, the grid could return the same cell for every location.

## Update rules

Is 'a cell has 8 neighbours' a testable statement? If we ask the grid for
neighbours, how do we represent them? In this case, I have chosen to skip this
step and go straight to the update rules. I could have applied the same
heuristic for the rectangular grid requirement.

It is important here to keep implementing as little as possible.

How do we test all possible configurations? We may not need to. The goal is not
to test all configurations, but to guide design. By adding at each step a
failing test, you get most bang for your tests. At some point, the next failing
test will force you to generalize the design.

How do you test that all cells are updated?

## Simultaneous updates

Just testing one other cell forced me to update all cells simultaneously.

Try some classic life patterns.


## Think about:

- Who knows about the rules? What other options are there?
  - The grid?
  - The cell?
  - An external ruler?
- What would you change about the design?
- How hard is it to create system with different rules? Can you change the
  design to make this easier?
- Can you update cells right under the grid's nose? Is that a good thing?

- Are there any methods that should become private? Why?
