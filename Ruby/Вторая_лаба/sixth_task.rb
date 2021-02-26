def get_elem_more_sum_prev(arr)
	new_arr = []
	for i in 1..arr.size-1
		if arr[i] > arr[0..i-1].sum()
			new_arr.push(arr[i])
		end
	end
	new_arr
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

print get_elem_more_sum_prev(arr).size