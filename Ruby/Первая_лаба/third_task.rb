puts 'Какой ваш любимый язык?'
lang = gets.chomp.downcase 

if lang == 'ruby'
	puts 'Подлиза'
else
	case lang 
	when 'c++'
		puts 'C++ - это хорошо, но Ruby лучше'
	when 'python'
		puts 'Неженка, переходи на Ruby'
	end
end
