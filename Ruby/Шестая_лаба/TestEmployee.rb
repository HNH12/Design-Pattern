require_relative 'Employee.rb'

class TestEmployee < Employee
	def get_full_info
		"Данные сотрудника: " + super
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

	def self.is_birthday?(date)
		is_birthday? date
	end

	def self.is_email?(email)
		is_email? email
	end
end