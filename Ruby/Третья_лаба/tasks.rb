class Employee
	attr_accessor :name, :birthday, :address, 
				  :e_mail, :passport_series, :passport_number, :specialty, :work_experience


	def is_rus_number(number)
		(number =~ /\+7-[0-9]{3}-[0-9]{7}|8[0-9]{10}|\+7-[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}/) != nil ? true : false
	end	

	def get_rus_number(number)
		begin
			is_rus_number(number) ? @phone_number =  number.gsub(/(^8)(\d{3})(\d{7})/, '+7-\2-\3'): raise
		rescue
			puts "Неверный тип аргумента"
		end
	end

	def initialize(name, birthday, phone_number, address, 
				  e_mail, passport, specialty, work_experience, 
				  previous_work = nil, previous_post = nil, previous_salary = nil)
		@name = name
		@birthday = birthday
		@phone_number = phone_number
		@address = address
		@e_mail = e_mail
		@passport = passport
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

	def phone_number=(x)
		@phone_number = get_rus_number x
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
end


first_emp = Employee.new("Толстиков Илья Вадимович", "22.12.1999", "89183616209", "Odesskay 44", "Henuhi86@gmail.com", 
	"0555 239999", "Programmer", 3, "Gazzprom", "Web", 54000)
second_emp = Employee.new("Толстиков Илья Вадимович", "22.12.1999", "89183616209", "Oddesskay 44", "Henuhi86@gmail.com", 
	"0555 239999", "Programmer", 0)


first_emp.phone_number = '89183616209'
puts first_emp.phone_number