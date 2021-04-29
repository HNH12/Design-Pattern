require 'mysql2'
require_relative 'Employee.rb'
require_relative 'ListEmployee.rb'
require_relative 'TerminalView.rb'


TerminalViewListEmployee.set_client("localhost", "root", "stuff")
TerminalViewListEmployee.read_list_DB
print TerminalViewListEmployee.show_list

TerminalViewListEmployee.change_node 'henuhi86@gmail.com'
