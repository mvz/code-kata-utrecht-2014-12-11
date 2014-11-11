# Your code goes here

class Grid
  def initialize x: nil, y: nil
    @cells = Array.new(x) { Array.new(y) }
  end

  def cell_at x:, y:
    @cells[x][y] ||= Cell.new
  end

  def update
    cell_at(x: 1, y: 1).die unless cell_at(x: 1, y: 0).alive? && cell_at(x: 0, y:0).alive?
  end
end

class Cell
  def dead?
    !@alive
  end

  def alive?
    @alive
  end

  def live
    @alive = true
  end

  def die
    @alive = false
  end
end
