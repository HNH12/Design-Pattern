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


def read_array(arr, count_el) 
	for i in 0..count_el-1
		el = $stdin.gets.to_i
		arr << el
	end
end


if ARGV[0] == "file"
	path = ARGV[1]
	print(read_file(path))
else
	count_el = ARGV[1].to_i

	arr = []
	read_array(arr, count_el)
	print arr
end