str = gets.chomp

puts str.split(' ').map {|el| el.to_i}.max