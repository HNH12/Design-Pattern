require_relative 'Employee.rb'


class Validate
	def self.is_employee?(*args)
		is_name?(args[0]) && is_birthday?(args[1]) &&
		is_rus_number?(args[2]) && is_full_info?(args[3])
		is_email?(args[4]) && is_passport?(args[5]) &&
		is_full_info?(args[6]) && is_full_info?(args[7])
	end

	def self.is_name? name
		Employee.is_name? name
	end

	def self.is_birthday? date
		Employee.is_birthday? date
	end

	def self.is_rus_number? number
		Employee.is_rus_number? number
	end

	def self.is_full_info? info
		info != nil && info != ''
	end

	def self.is_email? email
		Employee.is_email? email
	end

	def self.is_passport? passport
		Employee.is_passport? passport
	end
end