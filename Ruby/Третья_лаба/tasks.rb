class Employee
	attr_accessor :address, :specialty, :work_experience


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
		self.work_experience = work_experience

		if self.work_experience != 0
			self.previous_work = previous_work
			self.previous_post = previous_post
			self.previous_salary = previous_salary
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
		@work_experience != 0 ? @previous_salary = x : puts("Запись отклонена")
	end

	def get_full_info
		puts self.name
		puts self.birthday
		puts self.phone_number
		puts self.address
		puts self.email
		puts self.passport
		puts self.specialty
		puts self.work_experience

		if self.work_experience != 0
			puts self.previous_work = previous_work
			puts self.previous_post = previous_post
			puts self.previous_salary = previous_salary
		end
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

	def self.check_name(name)
		is_name? name
	end

	def self.check_passport(passport)
		is_passport? passport
	end

	def self.check_phone(phone)
		is_rus_number? phone
	end

	def self.check_date(date)
		is_birthday? date
	end

	def self.check_email(email)
		is_email? email
	end
end


first_emp = Employee.new("    Толстиков    Илья Вадимович   ", "22.12.1999", "89183616209", "Odesskay 44", "Henuhi86@gmail.com", 
	"0555239999", "Programmer", 3, "Gazzprom", "Web", 54000)
second_emp = Employee.new("Салтыков   -   Щедрин Иван-    Руслан    Ахмед    оглы", "1.12.1999", "89183616209", "Oddesskay 44", "Henuhi86@gmail.com", 
	"0555 239999", "Programmer", 0)


third_emp = TestEmployee.new("    Толстиков    Илья Вадимович   ", "22.12.1999", "89183616209", "Odesskay 44", "Henuhi86@gmail.com", 
	"0555239999", "Programmer", 3, "Gazzprom", "Web", 54000)

fourth_emp = TestEmployee.new("Салтыков   -   Щедрин Иван-    Руслан    Ахмед    оглы", "1.12.1999", "89183616209", "Oddesskay 44", "Henuhi86@gmail.com", 
	"0555 239999", "Programmer", 0)


puts "Укажите, что необходимо проверить:"
puts "1. ФИО"
puts "2. Телефон"
puts "3. Дата"
puts "4. Email"
puts "5. Паспорт"

puts
puts "Ваш выбор:"
choice = gets.chomp().to_i
puts "Введите данные: "
data = gets.chomp().force_encoding("Windows-1251")
puts data

case choice
when 1
	puts TestEmployee.check_name(data)
when 2
	puts TestEmployee.check_phone(data)
when 3
	puts TestEmployee.check_date(data)
when 4
	puts TestEmployee.check_email(data)
when 5
	puts TestEmployee.check_passport(data)
end