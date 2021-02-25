arr = gets.chomp.split().map { |e| e.to_i}

print 'Array: ', arr, "\n"
puts 'Min: ', arr.min
puts 'Max: ', arr.max
puts 'Sum: ', arr.sum
puts 'Mult: ', arr.inject(:*)
