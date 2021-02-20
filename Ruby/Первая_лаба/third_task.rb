puts 'Ваш любимый язык?'
lang = gets.chomp.downcase 

s = if lang == 'ruby' then 'Подлиза' else 'Скоро будет Ruby' end
puts s