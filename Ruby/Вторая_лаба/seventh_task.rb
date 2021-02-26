def read_file(path) 
	file = File.open(path)
	arr = []
	file.each do |line|
		arr = Array(
			line[1..-2].split(',').map {|el| el.to_i}
			)
	end
	file.close
	arr
end


def first_method()
	path = "file.txt"
	arr = read_file(path)

	index_min = arr.rindex(arr.min)
	if index_min > 0
		print arr[0..(index_min-1)]
	else
		print []
	end
end


def second_method()
	path = "file.txt"
	arr = read_file(path)

	index_max = arr.index(arr.max)
	if index_max < arr.size - 1
		print arr[(index_max+1)..arr.size-1]
	else
		print []
	end
end


def third_method()
	path = "file.txt"
	arr = read_file(path)
	
	new_arr = []
	if arr[0] >= 0
		new_arr = arr.select.with_index do |el, i| 
			((i.even? || i == 0) && el >= 0) || i.odd? && el < 0
		end
	else
		new_arr = arr.select.with_index do |el, i| 
			((i.even? || i == 0) && el < 0) || i.odd? && el >= 0
		end
	end

	if (new_arr.length == arr.length)
		print true
	else
		print false
	end
end


def falls_within_interval?(numb, range)
	if numb >= range[0] && numb <= range[1]
		return true
	end
	return false
end	


def get_sum_conditions(arr, range)
	arr.inject(0) {|sum, el| falls_within_interval?(el, range)? sum + el : sum}
end


def to_range(str)
	arr_interval = str.split('..').map { |el|  el.to_i}
	return arr_interval
end


def fourth_method()
	path = "file.txt"
	arr = read_file(path)

	puts "Введите интервал"
	str = $stdin.gets.chomp
	print 'Суммая элементов равна: ', get_sum_conditions(arr, to_range(str))
end


def get_elem_more_sum_prev(arr)
	return arr.select.with_index {|el, i| i == 0 || el > arr[0..i-1].sum}
end


def fifth_method()
	path = "file.txt"
	arr = read_file(path)

	puts 'Количество элементов: ', (get_elem_more_sum_prev arr).size
end


eval ARGV[0]