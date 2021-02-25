def get_min(arr) 
	min = arr[0]
	arr.each { |el| min = el if el < min}
	min
end


def get_max(arr)
	max = arr[0]
	arr.each { |el| max = el if el > max}
	max
end		


def get_sum(arr)
	sum = 0
	arr.each { |el| sum += el}
	sum
end


def get_mult(arr)
	mult = 1
	arr.each { |el| mult *= el}
	mult
end


arr = gets.chomp.split().map { |e| e.to_i}

print 'Array: ', arr, "\n"
puts 'Min: ', get_min(arr)
puts 'Max: ', get_max(arr)
puts 'Sum: ', get_sum(arr)
puts 'Mult: ', get_mult(arr)