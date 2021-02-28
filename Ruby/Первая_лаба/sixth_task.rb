def get_max_digit(number)
	number.digits.max
end


def get_min_digit(number)
	number.digits.min
end


def get_sum_digits(number)
	number.digits.reduce(:+)
end


def get_mult_digits(number)
	number.digits.inject(:*)
end


number = ARGV[0].to_i

print "\nСумма цифр: ", get_sum_digits(number), "\n"
print "\nПроизведение цифр: ", get_mult_digits(number), "\n"
print "\nМинимальная цифра: ", get_min_digit(number), "\n"
print "\nМаксимальная цифра: ", get_max_digit(number), "\n"