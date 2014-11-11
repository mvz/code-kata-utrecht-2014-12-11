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
    num_alive = live_neighbour_count_array
    each_cell_location do |x, y|
      live_neighbours = num_alive[x][y]
      cell_at(x: x, y: y).live if live_neighbours == 3
      cell_at(x: x, y: y).die unless [2, 3].include? live_neighbours
    end
  end

  def to_s
    @height.times.map { |y|
      @width.times.map { |x|
        cell_at(x: x, y: y).to_s
      }.join
    }.join("\n")
  end

  private

  def each_cell_location
    @width.times do |x|
      @height.times do |y|
        yield x, y
      end
    end
  end

  def live_neighbour_count_array
    num_alive = Array.new(@width) { Array.new(@height) }

    each_cell_location do |x, y|
      num_alive[x][y] = live_neighbour_count_at(x, y)
    end

    num_alive
  end

  def live_neighbour_count_at(x, y)
    num_alive = 0
    each_neighbour(x, y) do |other_x, other_y|
      num_alive += 1 if cell_at(x: other_x, y: other_y).alive?
    end
    num_alive
  end

  def each_neighbour(x, y)
    horizontal_neighbour_range(x).each do |other_x|
      vertical_neighbour_range(y).each do |other_y|
        next if other_x == x && other_y == y
        yield other_x, other_y
      end
    end
  end

  def vertical_neighbour_range(y)
    start = [0, y - 1].max
    finish = [@height - 1, y + 1].min
    start..finish
  end

  def horizontal_neighbour_range(x)
    start = [0, x - 1].max
    finish = [@width - 1, x + 1].min
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

  def to_s
    alive? ? '*' : '.'
  end
end
