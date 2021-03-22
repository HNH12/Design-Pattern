def is_simple?(number)
	if number == 1 || number == 0
		return false
	end

	(2..number-1).each do |div| 
		return false if number%div == 0
	end
	true
end


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
		if number%div == 0 && is_simple?(div) && div > current_max_div
			current_max_div = div
		end
	end
	print "\nМакс. простой дел. числа: ", current_max_div
end


def get_mult_digit_not_divisible_five(number)
	print "\nПроизведение цифр, не дел. на 5: ", number.digits.inject(1) { |mult, el| el % 5 != 0 ? mult *= el : mult }
end


def get_max_simple_odd_div(number)
	return 0 if number == 0

	current_max_odd_div = 1
	(2..number).each do |div|
		if number%div == 0 && !is_simple?(div) && div > current_max_odd_div && div%2 != 0
			current_max_odd_div = div
		end
	end
	current_max_odd_div
end


def get_nod(first_num, second_num)
	while(first_num != second_num) do
		if first_num > second_num
			first_num -= second_num
		else
			second_num -= first_num
		end
	end
	first_num
end


def get_nod_by_task(number)
	print "\nНОД: ", get_nod(get_max_simple_odd_div(number), get_mult_digits(number))
end


begin
	raise if ARGV.length < 2
	for i in 0..ARGV.length - 2
		param = ARGV[i] + ' ' + ARGV[ARGV.length-1]
	   	eval param
	   	puts
   	end
rescue SyntaxError
	puts
	puts "Hello World"
	puts "Подсказка:"
	puts "get_max_simple_div(number)"
	puts "get_mult_digit_not_divisible_five(number)"
	puts "get_nod_by_task(number)\n"
rescue
	puts
   	puts 'Hello World'
   	puts "Подсказка:"
   	puts "get_max_simple_div(number)"
	puts "get_mult_digit_not_divisible_five(number)"
	puts "get_nod_by_task(number)\n"
end