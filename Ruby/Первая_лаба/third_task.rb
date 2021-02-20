puts 'Какой ваш любимый язык?'
lang = gets.chomp.downcase 

lang == 'ruby' ? puts('Подлиза'): puts('Скоро будет Ruby')