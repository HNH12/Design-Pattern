require 'openssl'


if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


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
		begin
			is_rus_number?(new_number) ? form_rus_number(new_number): raise(TypeError)
		rescue => error
			puts error.message
		end
	end

	def self.is_email?(new_email)
		(new_email =~ /^((([0-9A-Za-z]{1}[-0-9A-z\.]{1,}[0-9A-Za-z]{1})|([0-9А-Яа-я]{1}[-0-9А-я\.]{1,}[0-9А-Яа-я]{1}))@([-A-Za-z]{1,}\.){1,2}[-A-Za-z]{2,})$/) == 0 ? true : false
	end

	def self.get_email_downcase(new_email)
		begin
			is_email?(new_email) ? new_email.downcase : raise(TypeError)
		rescue => error
			puts error.message
		end
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
		begin
			is_name?(new_name) ? new_name.strip().gsub(/(\s{2,})/, ' ').gsub(/\s*-\s*/, '-').gsub(/[А-яё]+/) {|word| word.capitalize} : raise(TypeError)
		rescue => error
			puts error.message
		end
	end

	def self.is_birthday?(new_birthday)
		(new_birthday =~ /([1-9]|0[1-9]|[12][0-9]|3[01])[.](0[1-9]|1[012])[.]\d{2,4}/) == 0 ? true : false
	end

	def self.form_date(date_str)
		date = date_str.gsub(/(\d+).(\d+).(\d+)/, '\3 \2 \1').split(' ')
		year = date[0]
		month = date[1]
		day = date[2]
		Time.new(year, month, day).strftime("%d.%m.%Y")
	end

	def self.get_birthday(new_birthday)
		begin
			is_birthday?(new_birthday) ? form_date(new_birthday) : raise(TypeError)
		rescue => error
			puts error.message
		end
	end

	def self.is_passport?(new_passport)
		(new_passport =~ /(\d{10}|(\d{4}\s\d{6}))/) == 0 ? true : false
	end

	def self.get_passport(new_passport)
		begin
			is_passport?(new_passport) ? new_passport.gsub(/(\d{4})(\d{6})/, '\1 \2') : raise(TypeError)
		rescue => error
			puts error.message
		end
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
		@phone_number = Employee.get_rus_number new_phone_number
	end

	def email
		@email
	end

	def email=(new_email)
		@email = Employee.get_email_downcase new_email
	end

	def name
		@name
	end

	def name=(new_name)
		@name = Employee.get_name new_name
	end

	def birthday
		@birthday
	end

	def birthday=(new_birthday)
		@birthday = Employee.get_birthday new_birthday
	end

	def passport
		@passport
	end

	def passport=(new_passport)
		@passport = Employee.get_passport new_passport
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
		@work_experience != 0 ? @previous_work = x : puts("Запись отклонена")
	end

	def previous_post=(x)
		@work_experience != 0 ? @previous_post = x : puts("Запись отклонена")
	end

	def previous_salary=(x)
		@work_experience != 0 ? @previous_salary = x.to_f : puts("Запись отклонена")
	end

	def get_full_info
		puts self.name + ";"
		puts self.birthday + ";"
		puts self.phone_number.to_s + ";"
		puts self.address + ";"
		puts self.email + ";"

		keys = OpenSSL::PKey::RSA.new File.open("certificate.pem")
		res = keys.public_encrypt(self.passport)
		puts res.to_s + ";"

		puts self.specialty + ";"
		puts self.work_experience.to_s + ";"

		if self.work_experience != 0
			puts self.previous_work + ";"
			puts self.previous_post + ";"
			puts self.previous_salary.to_s + ";"
		end
		puts
	end
end


class TestEmployee < Employee
	def get_full_info
		puts "Имя: ", self.name
		puts "Дата рождения: ", self.birthday
		puts "Номер телефона:", self.phone_number
		puts "Адрес: ", self.address
		puts "Email: ", self.email
		puts "Паспорт: ", self.passport
		puts "Профессия: ", self.specialty
		puts "Опыт работы: ", self.work_experience

		if self.work_experience != 0
			puts "Предыдущее место работы: ", self.previous_work = previous_work
			puts "Предыдущее работа: ", self.previous_post = previous_post
			puts "Предыдущая зарплаты: ", self.previous_salary = previous_salary
		end
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


class TerminalViewListEmployee
	@@list_employee = []

	def self.append
		is_not_appended = true
		while(is_not_appended)
			begin 
				print "\nВведите ФИО: "
				name = gets.chomp
				print "\nВведите дату: "
				date = gets.chomp
				print "\nВведите телефон: "
				phone = gets.chomp()
				print "\nВведите адрес: "
				address = gets.chomp()
				print "\nВведите email: "
				email = gets.chomp()
				print "\nВведите паспортные данные: "
				passport = gets.chomp()
				print "\nВведите специальность: "
				specialty = gets.chomp()
				print "\nВведите опыт работы: "
				work_experience = gets.chomp().to_f

				previous_work = nil
				previous_post = nil
				previous_salary = nil

				if work_experience != 0
					print "\nВведите предыдущее место работы: "
					previous_work = gets.chomp()
					print "\nВведите предыдущую специальность: "
					previous_post = gets.chomp()
					print "\nВведите предыдущую зарплату: "
					previous_salary = gets.chomp().to_f
				end

				if [Employee.get_name(name), Employee.get_birthday(date), Employee.get_rus_number(phone), address,
				 	Employee.get_email_downcase(email), Employee.get_passport(passport)].include? nil 
					raise TypeError
				else
					@@list_employee.push(Employee.new(name, date, phone, address, email, passport, specialty, work_experience, 
						previous_work, previous_post, previous_salary))
					is_not_appended = false
				end

			rescue
				puts "Некорректные данные. Введите данные ещё раз"
				print [Employee.get_name(name), Employee.get_birthday(date), Employee.get_rus_number(phone), address,
				 	Employee.get_email_downcase(email), Employee.get_passport(passport)]
			end
		end
	end

	def self.write_to_file(file_path)
		old_stdout = $stdout
		File.open(file_path, 'w:ASCII-8BIT') do |file| 
			$stdout = file
			@@list_employee.each { |obj| file.write obj.get_full_info }
		end
		$stdout = old_stdout
	end

	def self.read_from_file(file_path)
		employees = File.open(file_path , 'r') { |file| file.read}
	end

	def self.show_list
		@@list_employee.each { |obj| obj.get_full_info }
	end

	def self.find_employee(name, email=nil, phone=nil, passport=nil)
		if passport
			return(Employee.return_employee_by_name(name) & Employee.return_employee_by_passport(name) &
				Employee.return_employee_by_phone_number(phone) & Employee.return_employee_by_email(email))
		end

		if phone
			return(Employee.return_employee_by_name(name) & Employee.return_employee_by_phone_number(phone) & 
				Employee.return_employee_by_email(email))
		end

		if email
			return(Employee.return_employee_by_name(name) & Employee.return_employee_by_email(email))
		end

		Employee.return_employee_by_name name
	end
end


TerminalViewListEmployee.append
TerminalViewListEmployee.append
TerminalViewListEmployee.write_to_file("write_file.txt")
TerminalViewListEmployee.read_from_file("write_file.txt")

puts Employee.return_employee_by_name("Толстиков Илья Вадимович")

# Толстиков Илья Вадимович
# 22.12.1999
# 89183616209
# Одесская 44
# henuhi86@gmail.com
# 3333444455
# Программист
# 0


# Толстиков Иль Вадимович
# 22.02.1999
# 89183616219
# Одесская 4
# henuhi8@gsmail.com
# 3333444456
# Почти программист
# 0