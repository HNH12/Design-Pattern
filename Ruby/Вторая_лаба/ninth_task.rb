def first_method()
	str = gets.chomp.split(' ')

	puts str.shuffle.join(' ') 
end


def second_method()
	str = gets.chomp.split(' ')

	puts str.inject(0) { |sum, el| el.size.even? ? sum += 1 : sum } 
end


def third_method()
	arr = ['синий', 'белый', 'красный']

	new_arr =  arr.sort do |a,b|
		 a.length > b.length ? 1 : a > b ? 1 : -1
	end

	print new_arr
end


eval ARGV[0]