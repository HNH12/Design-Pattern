puts 'Какой ваш любимый язык?'
lang = gets.chomp.downcase 

if lang == 'ruby'
	puts 'Подлиза'
elsif lang == '1c'
	puts 'Ясно...'
else
	puts 'Скоро будет Ruby'
end