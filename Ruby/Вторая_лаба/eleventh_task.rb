arr_char = "апр п р авы а п s d ew e ё".split('')

puts (arr_char.select do |symb| 
		((symb.downcase >= 'а') && (symb.downcase <= 'я')) || (symb.downcase == 'ё')
	end).size