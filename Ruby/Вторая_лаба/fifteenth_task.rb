def read_file(path) 
	file = File.open(path)
	lines = []
	file.each do |line|
		lines.push(line.chomp)
	end
	file.close
	lines
end


def get_most_frequent_character_in_string(str)
	arr = str.split('')
	most_frequent_char = arr.max { |a| arr.count(a).to_f/arr.size.to_f }
	return most_frequent_char, arr.count(most_frequent_char).to_f/arr.size.to_f
end


def get_frequency_in_text(lines, char)
	str_lines = lines.join("")

	return str_lines.count(char).to_f/str_lines.size.to_f
end


def get_square_deviation(lines, str)
	most_frequent_char, char_frequecy_in_str = get_most_frequent_character_in_string str
	return Math.sqrt((char_frequecy_in_str - get_frequency_in_text(lines, most_frequent_char)).abs)
end


def sort_by_task_5(lines)
	print lines.sort { |first_str, second_str| get_square_deviation(lines, first_str) <=> get_square_deviation(lines, second_str)}	
end


path = "file.txt"
lines = read_file(path)

sort_by_task_5(lines)