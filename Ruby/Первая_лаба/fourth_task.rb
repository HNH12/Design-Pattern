puts ' Введите команду Ruby'
comand_ruby = gets.chomp
puts 'Введите команду ОС'
comand_os = gets.chomp
eval comand_ruby
puts `#{comand_os}`