def is_simple?(number)
	if number == 1 || number == 0
		return false
	end

	(2..number-1).each do |div| 
		return false if number%div == 0
	end
	true
end


def get_mult_digit_number(number)
	return 0 if number == 0

	mult = 1
	number.to_s.split('').each{|el| mult *= el.to_i}
	mult
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
	get_nod(get_max_simple_odd_div(number), get_mult_digit_number(number))
end


number = ARGV[0].to_i
puts get_nod_by_task(number)