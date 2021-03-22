require 'prime'


def get_max_digit_number(number)
	number.digits.max
end


def get_min_digit_number(number)
	number.digits.min
end


def get_sum_digits(number)
	number.digits.reduce(:+)
end


def get_mult_digits(number)
	number.digits.inject(:*)
end


def get_max_simple_div(number)
	current_max_div = 1
	(1..number).each do |div|
		if number%div == 0 && Prime.prime?(div) && div > current_max_div
			current_max_div = div
		end
	end
	current_max_div
end


def get_mult_digit_not_divisible_five(number)
	number.digits.inject(1) { |mult, el| el % 5 != 0 ? mult *= el : mult }
end


def get_max_simple_odd_div(number)
	return 0 if number == 0

	current_max_odd_div = 1
	(2..number).each do |div|
		if number%div == 0 && !Prime.prime?(div) && div > current_max_odd_div && div.odd?
			current_max_odd_div = div
		end
	end
	current_max_odd_div
end


def get_nod_by_task(number)
	get_max_simple_odd_div(number).gcd(get_mult_digits(number))
end


begin
	raise if ARGV.length < 2
	for i in 0..ARGV.length - 2
		param = ARGV[i] + ' ' + ARGV[ARGV.length-1]
	   	puts eval param
	   	puts
   	end
rescue SyntaxError
	puts 'Hello World'
rescue
   	puts 'Hello World'
end