# Grid of cells
class Grid
  def initialize(x: nil, y: nil)
    @cells = Array.new(x) { Array.new(y) }
    @width = x
    @height = y
  end

  def cell_at(x:, y:)
    @cells[x][y] ||= Cell.new
  end

  def update
    num_alive = Array.new(@width) { Array.new(@height) }

    @width.times do |x|
      @height.times do |y|
        num_alive[x][y] = live_neighbour_count_at(x, y)
      end
    end

    @width.times do |x|
      @height.times do |y|
        live_neighbours = num_alive[x][y]
        cell_at(x: x, y: y).live if live_neighbours == 3
        cell_at(x: x, y: y).die unless [2, 3].include? live_neighbours
      end
    end
  end

  private

  def live_neighbour_count_at(x, y)
    num_alive = 0
    each_neighbour(x, y) do |other_x, other_y|
      num_alive += 1 if cell_at(x: other_x, y: other_y).alive?
    end
    num_alive
  end

  def each_neighbour(x, y)
    horizontal_neighbour_range(x).each do |other_x|
      next if other_x >= @width || other_x < 0
      vertical_neighbour_range(y).each do |other_y|
        next if other_y >= @height || other_y < 0
        next if other_x == x && other_y == y
        yield other_x, other_y
      end
    end
  end

  def vertical_neighbour_range(y)
    start = [0, y - 1].max
    finish = [@height, y + 1].min
    start..finish
  end

  def horizontal_neighbour_range(x)
    start = [0, x - 1].max
    finish = [@width, x + 1].min
    start..finish
  end
end

# Represent single cell, dead or alive.
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
