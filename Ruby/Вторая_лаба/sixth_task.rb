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


path = "file.txt"
arr = read_file(path)

index_last_min_elem = get_elements_before_min(arr)-1
if  index_last_min_elem > -1
	print arr[0..index_last_min_elem]
else
	print []
end