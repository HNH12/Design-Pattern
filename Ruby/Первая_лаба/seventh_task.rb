def is_simple?(number)
	(2..number-1).each do |div| 
		return false if number%div == 0
	end
	true
end


def get_max_simple_div(number)
	current_max_div = 1
	(1..number).each do |div|
		if number%div == 0 && is_simple?(div) && div > current_max_div
			current_max_div = div
		end
	end
	current_max_div
end


puts get_max_simple_div(ARGV[0].to_i)