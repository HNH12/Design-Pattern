def read_array(arr, count_el) 
	for i in 0..count_el-1
		el = $stdin.gets.to_i
		arr += [el]		
	end
	arr
end


count_el = ARGV[0].to_i

arr = []
arr = read_array(arr, count_el)
print arr