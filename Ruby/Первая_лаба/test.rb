puts 'Какой ваш любимый язык?'
lang = gets.chomp.downcase 

if lang == 'ruby'
	puts 'У нас тут подлиза'
else
	case lang 
	when 'c++'
		puts 'C++ - это хорошо, но Ruby лучше'
	when 'python'
		puts 'Неженка, переходи на Ruby'
	end
end

# RubyMine
# RubyDocs - документация
# 9 вариант