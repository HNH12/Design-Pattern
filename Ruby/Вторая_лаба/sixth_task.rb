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


def get_elements_before_min(arr)
	index_min = 0
	min = arr[0]
	for i in 0..arr.size-1
		if arr[i] <= min
			index_min = i
			min = arr[i]
		end
	end
	index_min
end


def first_method()
	path = "file.txt"
	arr = read_file(path)
	
	index_last_min_elem = (get_elements_before_min arr) - 1
	if  index_last_min_elem > -1
		puts
		print 'Элементы перед последним минимальным: ', arr[0..index_last_min_elem]
	else
		puts
		print 'Элементы перед последним минимальным: ', []
	end 
end


def get_elements_after_max(arr)
	index_max = 0
	max = arr[0]
	for i in 0..arr.size-1
		if arr[i] > max
			index_max = i
			max = arr[i]
		end
	end
	index_max
end


def second_method()
	path = "file.txt"
	arr = read_file(path)
	
	index_first_max_elem = (get_elements_after_max arr) + 1
	if  index_first_max_elem < arr.size
		puts
		print 'Элементы после первого максимального: ', arr[index_first_max_elem..]
	else
		puts
		print 'Элементы после первого максимального: ', []
	end
end


def is_alternating?(arr)
	for i in 1..arr.size-1
		if (arr[i] > 0 && arr[i-1] > 0) || (arr[i] < 0 && arr[i-1] < 0)
			return false
		end
	end
	true
end


def third_method()
	path = "file.txt"
	arr = read_file(path)
	
	puts 'Является ли последовательность чередующейся: ', is_alternating?(arr)
end


def falls_within_interval?(numb, range)
	if numb >= range[0] && numb <= range[1]
		return true
	end
	return false
end	


def get_sum_conditions(arr, range)
	sum = 0
	arr.each do |el|
		if falls_within_interval?(el, range)
			sum += el
		end
	end
	sum
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
	new_arr = []
	for i in 1..arr.size-1
		if arr[i] > arr[0..i-1].sum()
			new_arr.push(arr[i])
		end
	end
	new_arr
end


def fifth_method()
	path = "file.txt"
	arr = read_file(path)

	puts 'Количество элементов: ', (get_elem_more_sum_prev arr).size
end


eval ARGV[0]