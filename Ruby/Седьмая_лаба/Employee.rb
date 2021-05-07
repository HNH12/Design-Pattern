class Employee
	attr_accessor :address, :specialty, :work_experience

	def self.return_employee_by_name(needed_name)
		needed_name = get_name needed_name
		list_employee = []

		ObjectSpace.each_object(Employee) do |obj| 
			if obj.name == needed_name 
				list_employee.push(obj) 
			end
		end
		list_employee.length == 0 ? "Не найдено" : list_employee
	end

	def self.return_employee_by_email(needed_email)
		needed_email = get_email_downcase needed_email
		list_employee = []

		ObjectSpace.each_object(Employee) do |obj| 
			if obj.email == needed_email  
				list_employee.push(obj)
			end
		end
		list_employee.length == 0 ? "Не найдено" : list_employee
	end

	def self.return_employee_by_phone_number(needed_number)
		needed_number = get_rus_number needed_number
		list_employee = []

		ObjectSpace.each_object(Employee) do |obj| 
			if obj.phone_number == needed_number 
				list_employee.push(obj) 
			end
		end
		list_employee.length == 0 ? "Не найдено" : list_employee
	end

	def self.return_employee_by_passport(needed_passport)
		needed_passport = get_passport needed_passport
		list_employee = []

		ObjectSpace.each_object(Employee) do |obj| 
			if obj.passport == needed_passport 
				list_employee.push(obj) 
			end
		end
		list_employee.length == 0 ? "Не найдено" : list_employee
	end

	def self.is_rus_number?(new_number)
		new_number.scan(/\d/).size == 11 ? true : false
	end	

	def self.form_rus_number(new_number)
		number = new_number.scan(/\d/)

		"7-" + number[1,3].join('')+"-"+number[4..].join('')
	end

	def self.get_rus_number(new_number)
		is_rus_number?(new_number) ? form_rus_number(new_number): raise(ArgumentError)
	end

	def self.is_email?(new_email)
		(new_email =~ /^((([0-9A-Za-z]{1}[-0-9A-z\.]{1,}[0-9A-Za-z]{1})|([0-9А-Яа-я]{1}[-0-9А-я\.]{1,}[0-9А-Яа-я]{1}))@([-A-Za-z]{1,}\.){1,2}[-A-Za-z]{2,})$/) == 0 ? true : false
	end

	def self.get_email_downcase(new_email)
		is_email?(new_email) ? new_email.downcase : ArgumentError
	end

	def self.is_name?(new_name)
		regx = /(([А-яё]+\s*-\s*[А-яё]+\s+)|([А-яё]+\s+))(([А-яё]+\s*-\s*[А-яё]+\s+)|([А-яё]+\s+))(([А-яё]+\s+[А-яё]+\s*$)|([А-яё]+\s*$))/
		if (new_name =~ regx) != nil
			true
		else
			false
		end
	end

	def self.get_name(new_name)
		is_name?(new_name) ? new_name.strip().gsub(/(\s{2,})/, ' ').gsub(/\s*-\s*/, '-').gsub(/[А-яё]+/) {|word| word.capitalize} : raise(ArgumentError)
	end

	def self.is_birthday?(new_birthday)
		(new_birthday =~ /(\d{2,4}[-](0[1-9]|1[012])[-]([1-9]|0[1-9]|[12][0-9]|3[01]))/) == 0 ? true : false
	end

	def self.form_date(date_str)
		date = date_str.gsub(/(\d+).(\d+).(\d+)/, '\1 \2 \3').split(' ')
		year = date[0]
		month = date[1]
		day = date[2]
		Time.new(year, month, day).strftime("%Y-%m-%d")
	end

	def self.get_birthday(new_birthday)
		is_birthday?(new_birthday) ? form_date(new_birthday) : raise(ArgumentError)
	end

	def self.is_passport?(new_passport)
		(new_passport =~ /(\d{10}|(\d{4}\s\d{6}))/) == 0 ? true : false
	end

	def self.get_passport(new_passport)
		is_passport?(new_passport) ? new_passport.gsub(/(\d{4})(\d{6})/, '\1 \2') : raise(ArgumentError)
	end

	def initialize(name, birthday, phone_number, address, 
				  email, passport, specialty, work_experience, 
				  previous_work = nil, previous_post = nil, previous_salary = nil)

		self.name = name
		self.birthday = birthday
		self.phone_number = phone_number
		self.address = address
		self.email = email
		self.passport = passport
		self.specialty = specialty
		self.work_experience = work_experience.to_f

		if self.work_experience != 0
			self.previous_work = previous_work
			self.previous_post = previous_post
			self.previous_salary = previous_salary.to_f
		end
	end

	def phone_number
		@phone_number
	end

	def phone_number=(new_phone_number)
		begin
			@phone_number = Employee.get_rus_number new_phone_number
		rescue => error
			error.message
		end
	end

	def email
		@email
	end

	def email=(new_email)
		begin
			@email = Employee.get_email_downcase new_email
		rescue => error
			error.message
		end
	end

	def name
		@name
	end

	def name=(new_name)
		begin
			@name = Employee.get_name new_name
		rescue => error
			error.message
		end
	end

	def birthday
		@birthday
	end

	def birthday=(new_birthday)
		begin
			@birthday = Employee.get_birthday new_birthday
		rescue => error
			error.message
		end
	end

	def passport
		@passport
	end

	def passport=(new_passport)
		begin
			@passport = Employee.get_passport new_passport
		rescue => error
			error.message
		end
	end

	def previous_work
		@previous_work ? @previous_work : "Поле не указано"
	end

	def previous_post
		@previous_post ? @previous_post : "Поле не указано"
	end

	def previous_salary
		@previous_salary ? @previous_salary : "Поле не указано"
	end

	def previous_work=(x)
		work_experience != 0 ? @previous_work = x : raise("Невозможно записать")
	end

	def previous_post=(x)
		work_experience != 0 ? @previous_post = x : raise("Невозможно записать")
	end

	def previous_salary=(x)
		work_experience != 0 ? @previous_salary = x.to_f : raise("Невозможно записать")
	end

	def get_full_info
		str = "#{name}, #{birthday}, #{phone_number}, #{address}, #{email}, #{passport}, #{specialty}, #{work_experience}"
		if work_experience != 0
			str += ", #{previous_work}, #{previous_post}, #{previous_salary}"
		end
		str += ";\n"
	end
end