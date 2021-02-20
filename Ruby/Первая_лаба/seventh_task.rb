def mult_digit_not_divisible_five(string_number)
	mult = 1
	string_number.to_s.split('').each do |el| 
		mult *= el.to_i if el.to_i % 5 != 0
	end
	mult
end


number = ARGV[0].to_i
puts mult_digit_not_divisible_five(number)