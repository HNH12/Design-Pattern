def read_file(path) 
	file = File.open(path)
	lines = []
	file.each do |line|
		lines.push(line.chomp)
	end
	file.close
	lines
end


def get_most_ASCII_character_in_string(str)
	arr = str.split('')
	most_frequent_char = arr.max { |a| a.ord }
	return most_frequent_char.ord
end


def differences_ASCII_pairs(str)
	largest_dif = 0
	if str.size.even?
		for i in 0..(str.size-1)/2
			if (str[i].ord - str[str.size-1-i].ord).abs > largest_dif
				largest_dif = (str[i].ord - str[str.size-1-i].ord).abs
			end
		end
	else
		for i in 0..(str.size)/2
			if (str[i].ord - str[str.size-1-i].ord).abs > largest_dif
				largest_dif = (str[i].ord - str[str.size-1-i].ord).abs
			end
		end
	end
	return largest_dif
end


def get_square_deviation_9_issue(str)
	char_frequecy_in_str = get_most_ASCII_character_in_string str
	return Math.sqrt((char_frequecy_in_str-differences_ASCII_pairs(str)).abs)
end


def sort_by_task_9(lines)
	print lines.sort { |first_str, second_str| get_square_deviation_9_issue(first_str) <=> get_square_deviation_9_issue(second_str)}	
end


path = "file.txt"
lines = read_file(path)

sort_by_task_9(lines)