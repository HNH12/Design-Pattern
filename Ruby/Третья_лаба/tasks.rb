class Employee
	attr_accessor :name, :birthday, :phone_number, :address, 
				  :e_mail, :passport_series, :passport_number, :specialty, :work_experience


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

second_emp.previous_post = 12