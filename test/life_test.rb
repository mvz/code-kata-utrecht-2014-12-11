require 'test_helper'
require 'life'

class LifeTest < MiniTest::Test
  def test_rectangular_grid
    grid = Grid.new(x: 4, y: 3)
    assert_instance_of Cell, grid.cell_at(x: 2, y: 3)
  end

  def test_cells_can_live_and_die
    cell = Cell.new
    assert cell.dead?
    refute cell.alive?
    cell.live
    assert cell.alive?
    refute cell.dead?
    cell.die
    assert cell.dead?
    refute cell.alive?
  end
end
