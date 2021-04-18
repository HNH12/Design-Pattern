require_relative 'Clients.rb'


class Validate
	def self.is_client?(*args)
		is_name?(args[0]) && is_rus_number?(args[1]) && is_passport?(args[2])
	end

	def self.is_name? name
		Clients.is_name? name
	end

	def self.is_rus_number? number
		Clients.is_rus_number? number
	end

	def self.is_passport? passport
		CLients.is_passport? passport
	end
end