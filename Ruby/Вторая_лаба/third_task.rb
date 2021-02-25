def read_array(arr, count_el) 
	for i in 0..count_el-1
		el = $stdin.gets.to_i
		arr << el
	end
end


count_el = ARGV[0].to_i

arr = []
read_array(arr, count_el)
print arr