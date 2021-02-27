arr_char = "asd ds da AZ da sd фыв фыв фа".split('')

print (arr_char.select do |symb| 
		((symb.downcase >= 'a') && (symb.downcase <= 'z'))
	end).uniq


str = "asd ds da AZ da sd фыв фыв фа"
puts
print str.scan(/[A-z]/).uniq