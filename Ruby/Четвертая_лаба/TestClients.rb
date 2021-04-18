require_relative 'Clients.rb'


class TestClients < Clients
	def get_full_info
		"Данные клиента: " + super
	end

	def self.is_name?(name)
		is_name? name
	end

	def self.is_passport?(passport)
		is_passport? passport
	end

	def self.is_rus_number?(phone)
		is_rus_number? phone
	end
end