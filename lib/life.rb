# Your code goes here

class Grid
  def initialize x: nil, y: nil
    @cells = Array.new(x) { Array.new(y) }
  end

  def cell_at x:, y:
    @cells[x][y] ||= Cell.new
  end

  def update
    num_alive = 0
    3.times do |x|
      3.times do |y|
        next if x == 1 && y == 1
        num_alive += 1 if cell_at(x: x, y: y).alive?
      end
    end
    cell_at(x: 1, y: 1).live if num_alive == 3
    cell_at(x: 1, y: 1).die unless num_alive > 1 && num_alive < 4
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
