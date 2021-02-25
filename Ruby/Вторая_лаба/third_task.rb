def read_array(arr, count_el) 
	for i in 0..count_el-1
		arr[i] = $stdin.gets.to_i
	end
end


count_el = ARGV[0].to_i

arr = []
read_array(arr, count_el)
print arr