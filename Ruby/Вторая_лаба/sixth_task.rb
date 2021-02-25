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


def get_elements_after_max(arr)
	index_max = 0
	max = arr[0]
	for i in 0..arr.size-1
		if arr[i] > max
			puts i
			index_max = i
			max = arr[i]
		end
	end
	index_max
end


path = "file.txt"
arr = read_file(path)


print arr
index_first_max_elem = get_elements_after_max(arr)+1
if  index_first_max_elem < arr.size
	print arr[index_first_max_elem..]
else
	print []
end