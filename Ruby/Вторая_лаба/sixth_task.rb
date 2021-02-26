def falls_within_interval?(numb, range)
	if numb >= range[0] && numb <= range[1]
		return true
	end
	return false
end	


def get_sum(arr, range)
	sum = 0
	arr.each do |el|
		if falls_within_interval?(el, range)
			sum += el
		end
	end
	return sum
end


def to_range(str)
	arr_interval = str.split('..').map { |el|  el.to_i}
	return arr_interval
end


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


path = "file.txt"
arr = read_file(path)

arr_interval = to_range(ARGV[0])	
print get_sum(arr, arr_interval)