require 'openssl'
require_relative 'TestClients.rb'
require_relative 'Clients.rb'
require_relative 'ListClients.rb'
require_relative 'Validate.rb'


class TerminalViewListClients
	@@list_clients = ListClients.new()
	

	def self.append
		is_not_appended = true
		while(is_not_appended)
			begin 
				print "\nВведите ФИО: "
				name = gets.chomp
				print "\nВведите телефон: "
				phone = gets.chomp()
				print "\nВведите паспортные данные: "
				passport = gets.chomp()

				if !Validate.is_clients?(name, phone, passports)
					raise TypeError
				else
					@@list_clients.append(Clients.new(name, phone, passport))
					is_not_appended = false
				end

			rescue => e
				puts 'Неверный тип аргумента'
			end
		end
	end

	def self.read_from_file(file_path)
		@@list_clients.read_from_file file_path
	end

	def self.write_to_file(file_path)
		@@list_clients.write_to_file file_path
	end

	def self.show_list
		@@list_clients.to_s
	end

	def self.find(data)
		cl = @@list_clients.find_cl data
		if cl == []
			puts 'Неверные данные'
		else
			cl
		end
	end

	def self.close_app
		exit(0)
	end
end