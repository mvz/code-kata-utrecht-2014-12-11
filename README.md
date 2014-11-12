# Conway's Game of Life

## Rules

- Rectangular grid of cells.
- Cells can be dead or alive.
- For each cell, consider its 8 neighbours.
- A living cell stays alive if it has 2 or 3 (?or 4?) living neighbours.
  Otherwise, it becomes dead.
- A dead cell becomes alive if it has exactly 3 living neighbours. Otherwise,
  it stays dead.
- All updates happen simultaneously.
- Cells at the edge have fewer neighbours. The missing neighbours are
  considered dead.
- ALT: The grid wraps around at the edges, so forms a torus.

## Examples

Try some classic life patterns:

<pre>
      .*.    ...    .*.
      .*. -> *** -> .*.
      .*.    ...    .*.
</pre>

<pre>
      ....    ....
      .**. -> .**.
      .**.    .**.
      ....    ....
</pre>

## Output

- Write a #to_s to display the grid (test driven).
- Write a runner to run and display generations on the terminal. This should be
  simple enough not to need tests.
  - Can you make it stop once the board stops changing
  - Can you slow it down?
