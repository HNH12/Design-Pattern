str = gets.chomp.split(' ')

puts str.inject(0) { |sum, el| el.size.even? ? sum += 1 : sum }