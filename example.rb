require_relative 'lib/life'

WIDTH = 40
HEIGHT = 30

grid = Grid.new(x: WIDTH, y: HEIGHT)

grid.each_cell do |cell|
  cell.live if [true, false].sample
end

current_s = grid.to_s
prev_s = nil
puts grid

500.times do |i|
  prev_prev_s = prev_s
  prev_s = current_s
  grid.update
  sleep 0.05
  puts '-' * WIDTH
  puts i
  puts '-' * WIDTH
  current_s = grid.to_s
  puts grid
  break if current_s == prev_s || current_s == prev_prev_s
end
