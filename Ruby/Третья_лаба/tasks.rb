class Employee
	attr_accessor :address, :specialty, :work_experience


	def is_rus_number?(new_number)
		(new_number =~ /\+7-[0-9]{3}-[0-9]{7}|8[0-9]{10}|\+7-[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}/) == 0 ? true : false
	end	

	def get_rus_number(new_number)
		begin
			is_rus_number?(new_number) ? new_number.gsub(/(^8)(\d{3})(\d{7})/, '+7-\2-\3'): raise
		rescue
			puts "Неверный тип аргумента"
		end
	end

	def is_email?(new_email)
		(new_email =~ /[A-z]{3,}\w*@(gmail|mail|edu)(.com|.ru|.kubsu.ru)/) == 0 ? true : false
	end

	def get_email_downcase(new_email)
		begin
			is_email?(new_email) ? new_email.downcase : raise
		rescue
			puts "Неверный тип аргумента"
		end
	end

	def is_name?(new_name)
		regx = /(([А-яё]+\s*-\s*[А-яё]+\s+)|([А-яё]+\s+))(([А-яё]+\s*-\s*[А-яё]+\s+)|([А-яё]+\s+))(([А-яё]+\s+[А-яё]+\s*$)|([А-яё]+\s*$))/
		if (new_name =~ regx) != nil
			true
		else
			false
		end
	end

	def get_name(new_name)
		begin
			is_name?(new_name) ? new_name.strip().gsub(/(\s{2,})/, ' ').gsub(/\s*-\s*/, '-').gsub(/[А-яё]+/) {|word| word.capitalize} : raise
		rescue
			puts "Неверный тип аргумента"
		end
	end

	def is_birthday?(new_birthday)
		(new_birthday =~ /([1-9]|0[1-9]|[12][0-9]|3[01])[.](0[1-9]|1[012])[.]\d{2,4}/) == 0 ? true : false
	end

	def form_date(date_str)
		date = date_str.gsub(/(\d+).(\d+).(\d+)/, '\3 \2 \1').split(' ')
		year = date[0]
		month = date[1]
		day = date[2]
		Time.new(year, month, day).strftime("%d.%m.%Y")
	end

	def get_birthday(new_birthday)
		begin
			is_birthday?(new_birthday) ? form_date(new_birthday) : raise
		rescue
			puts "Неверный тип аргумента"
		end
	end

	def is_passport?(new_passport)
		(new_passport =~ /(\d{10}|(\d{4}\s\d{6}))/) == 0 ? true : false
	end

	def get_passport(new_passport)
		begin
			is_passport?(new_passport) ? new_passport.gsub(/(\d{4})(\d{6})/, '\1 \2') : raise
		rescue
			puts "Неверный тип аргумента"
		end
	end

	def initialize(name, birthday, phone_number, address, 
				  email, passport, specialty, work_experience, 
				  previous_work = nil, previous_post = nil, previous_salary = nil)

		@name = get_name name
		@birthday = get_birthday birthday
		@phone_number = get_rus_number phone_number
		@address = address
		@email = get_email_downcase email
		@passport = get_passport passport
		@specialty = specialty
		@work_experience = work_experience

		if @work_experience == 0
			@previous_work = previous_work
			@previous_post = previous_post
			@previous_salary = previous_salary
		end
	end

	def phone_number
		@phone_number
	end

	def phone_number=(new_phone_number)
		@phone_number = get_rus_number new_phone_number
	end

	def email
		@email
	end

	def email=(new_email)
		@email = get_email_downcase new_email
	end

	def name
		@name
	end

	def name=(new_name)
		@name = get_name new_name
	end

	def birthday
		@birthday
	end

	def birthday=(new_birthday)
		@birthday = get_birthday new_birthday
	end

	def passport
		@passport
	end

	def passport=(new_passport)
		@passport = new_passport
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
		@work_experience != 0 ? @previous_post = x : puts("Запись отклонена")
	end

	def previous_post=(x)
		@work_experience != 0 ? @previous_post = x : puts("Запись отклонена")
	end

	def previous_salary=(x)
		@work_experience != 0 ? @previous_salary = x : puts("Запись отклонена")
	end

	private :is_rus_number?, :get_rus_number, :is_email?, :get_email_downcase, :is_name?, :get_name, :is_birthday?, :get_birthday,
			:form_date, :is_passport?, :get_passport
end


first_emp = Employee.new("    Толстиков    Илья Вадимович   ", "22.12.1999", "89183616209", "Odesskay 44", "Henuhi86@gmail.com", 
	"0555239999", "Programmer", 3, "Gazzprom", "Web", 54000)
second_emp = Employee.new("Салтыков   -   Щедрин Иван-    Руслан    Ахмед    оглы", "1.12.1999", "89183616209", "Oddesskay 44", "Henuhi86@gmail.com", 
	"0555 239999", "Programmer", 0)


puts first_emp.birthday
puts second_emp.birthday

puts first_emp.passport