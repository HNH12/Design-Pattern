def sum_digits(string_number)
	sum = 0
	for x in string_number.split('')
		sum += x.to_i
	end
	sum
end


def max_digit_number(string_number)
	string_number.split('').max
end


def min_digit_number(string_number)
	string_number.split('').min
end


number = ARGV[0]

puts sum_digits(number)
puts max_digit_number(number)
puts min_digit_number(number)