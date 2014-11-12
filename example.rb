require_relative 'lib/life'

grid = Grid.new(x: 20, y: 14)

grid.each_cell do |cell|
  cell.live if [true, false].sample
end

current_s = grid.to_s
puts grid

500.times do |i|
  prev_s = current_s
  grid.update
  sleep 0.1
  puts '-' * 20
  puts i
  puts '-' * 20
  current_s = grid.to_s
  puts grid
  break if current_s == prev_s
end
