arr_str = gets.chomp.split(' ').select{|el| el.to_f == el.to_i}.map{|el| el.to_i}

print arr_str.min