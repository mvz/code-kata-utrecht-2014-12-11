# Your code goes here

class Grid
  def initialize x: nil, y: nil

  end

  def cell_at x:, y:
    Cell.new
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
