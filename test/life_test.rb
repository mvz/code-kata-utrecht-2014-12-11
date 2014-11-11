require 'test_helper'
require 'life'

# Test the game of life
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

  def test_cells_in_grid_are_persistent
    grid = Grid.new(x: 3, y: 3)
    grid.cell_at(x: 2, y: 2).live
    assert grid.cell_at(x: 2, y: 2).alive?
    assert grid.cell_at(x: 1, y: 0).dead?
  end

  def test_update_living_cell_no_neighbours_dies
    grid = Grid.new(x: 3, y: 3)
    grid.cell_at(x: 1, y: 1).live
    assert grid.cell_at(x: 1, y: 1).alive?
    grid.update
    assert grid.cell_at(x: 1, y: 1).dead?
  end

  def test_update_living_cell_1_neighbour_dies
    3.times do |x|
      3.times do |y|
        next if x == 1 && y == 1

        grid = Grid.new(x: 3, y: 3)
        grid.cell_at(x: 1, y: 1).live
        grid.cell_at(x: x, y: y).live

        assert grid.cell_at(x: 1, y: 1).alive?
        grid.update
        assert grid.cell_at(x: 1, y: 1).dead?
      end
    end
  end

  def test_update_living_cell_2_neighbours_lives
    grid = Grid.new(x: 3, y: 3)
    grid.cell_at(x: 1, y: 1).live
    grid.cell_at(x: 0, y: 0).live
    grid.cell_at(x: 1, y: 0).live
    assert grid.cell_at(x: 1, y: 1).alive?
    grid.update
    assert grid.cell_at(x: 1, y: 1).alive?
  end

  def test_update_living_cell_3_neighbours_lives
    grid = Grid.new(x: 3, y: 3)
    grid.cell_at(x: 1, y: 1).live
    grid.cell_at(x: 2, y: 2).live
    grid.cell_at(x: 1, y: 2).live
    grid.cell_at(x: 0, y: 2).live
    assert grid.cell_at(x: 1, y: 1).alive?
    grid.update
    assert grid.cell_at(x: 1, y: 1).alive?
  end

  def test_update_living_cell_4_neighbours_dies
    grid = Grid.new(x: 3, y: 3)
    grid.cell_at(x: 1, y: 1).live
    grid.cell_at(x: 0, y: 0).live
    grid.cell_at(x: 0, y: 2).live
    grid.cell_at(x: 1, y: 2).live
    grid.cell_at(x: 2, y: 2).live
    assert grid.cell_at(x: 1, y: 1).alive?
    grid.update
    assert grid.cell_at(x: 1, y: 1).dead?
  end

  def test_update_dead_cell_3_neighbours_becomes_alive
    grid = Grid.new(x: 3, y: 3)
    grid.cell_at(x: 1, y: 1).die
    grid.cell_at(x: 0, y: 0).live
    grid.cell_at(x: 0, y: 2).live
    grid.cell_at(x: 1, y: 2).live
    assert grid.cell_at(x: 1, y: 1).dead?
    grid.update
    assert grid.cell_at(x: 1, y: 1).alive?
  end

  def test_update_updates_all_cells
    grid = Grid.new(x: 3, y: 3)
    grid.cell_at(x: 0, y: 0).live
    assert grid.cell_at(x: 0, y: 0).alive?
    grid.update
    assert grid.cell_at(x: 0, y: 0).dead?
  end

  def test_flip_flop
    grid = Grid.new(x: 3, y: 3)
    3.times { |x| grid.cell_at(x: x, y: 1).live }
    grid.update
    3.times do |y|
      assert grid.cell_at(x: 0, y: y).dead?, "cell 0, #{y} should be dead"
      assert grid.cell_at(x: 1, y: y).alive?, "cell 1, #{y} should be alive"
      assert grid.cell_at(x: 2, y: y).dead?, "cell 2, #{y} should be dead"
    end
  end

  def test_to_s
    grid = Grid.new(x: 3, y: 3)
    3.times { |x| grid.cell_at(x: x, y: 1).live }
    assert_equal "...\n***\n...", grid.to_s
    grid.update
    assert_equal ".*.\n.*.\n.*.", grid.to_s
  end
end
