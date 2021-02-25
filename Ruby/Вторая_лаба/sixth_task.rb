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


def is_alternating?(arr)
	for i in 1..arr.size-1
		if (arr[i] > 0 && arr[i-1] > 0) || (arr[i] < 0 && arr[i-1] < 0)
			return false
		end
	end
	true
end


path = "file.txt"
arr = read_file(path)
puts is_alternating?(arr)