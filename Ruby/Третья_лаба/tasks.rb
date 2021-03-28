require 'openssl'
require_relative 'TestEmployee.rb'
require_relative 'Employee.rb'
require_relative 'ListEmployee.rb'
require_relative 'TerminalView.rb'



if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end



TerminalViewListEmployee.append
# TerminalViewListEmployee.append
TerminalViewListEmployee.write_to_file("write_file.txt")
TerminalViewListEmployee.read_from_file("write_file.txt")
print TerminalViewListEmployee.show_list


# a = TestEmployee.new("Толстиков Илья Вадимович","22.12.1999","89183616209","Одесская 44","henuhi86@gmail.com","3333444455" , "Программист", 0)
# puts a.get_full_info()

Толстиков Иль Вадимович
22.12.1999
89183616209
Одесская 44
henuhi86@gmail.com
3333444455
Программист
0


# Толстиков Cь Вадимович
# 22.02.1999
# 89183616219
# Одесская 4
# henuhi8@gsmail.com
# 3333444456
# Почти программист
# 0