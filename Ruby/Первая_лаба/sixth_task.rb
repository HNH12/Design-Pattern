def sum_digits(string_number)
	sum = 0
	string_number.split('').each{|el| sum += el.to_i}
	sum
end


def max_digit_number(string_number)
	string_number.split('').max
end


def min_digit_number(string_number)
	string_number.split('').min
end


def mult_digit_number(string_number)
	mult = 1
	string_number.split('').each{|el| mult *= el.to_i}
	mult
end


number = ARGV[0]

puts sum_digits(number)
puts max_digit_number(number)
puts min_digit_number(number)
puts mult_digit_number(number)