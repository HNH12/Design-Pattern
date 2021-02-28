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


def get_difference_by_task(lines, str)
	str_lines = lines.join("\n")

	most_frequent_char_in_str, char_frequecy_in_str = get_most_frequent_character_in_string(str)

	char_frequency_in_lines = str_lines.count(most_frequent_char_in_str).to_f/str_lines.size.to_f
	return (char_frequency_in_lines - char_frequecy_in_str).abs
end


def sort_by_task(lines)
	print lines.sort { |first_str, second_str| get_difference_by_task(lines, first_str) <=> get_difference_by_task(lines, second_str)}	
end


path = "file.txt"
lines = read_file(path)

sort_by_task(lines)