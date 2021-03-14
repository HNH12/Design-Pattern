class Employee
	attr_accessor :birthday, :address, :passport_series, :passport_number, :specialty, :work_experience


	def is_rus_number?(new_number)
		(new_number =~ /\+7-[0-9]{3}-[0-9]{7}|8[0-9]{10}|\+7-[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}/) != nil ? true : false
	end	

	def get_rus_number(new_number)
		begin
			is_rus_number?(new_number) ? new_number.gsub(/(^8)(\d{3})(\d{7})/, '+7-\2-\3'): raise
		rescue
			puts "Неверный тип аргумента"
		end
	end

	def is_email?(new_email)
		(new_email =~ /[A-z]{3,}\w*@(gmail|mail|edu)(.com|.ru|.kubsu.ru)/) != nil ? true : false
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

	def initialize(name, birthday, phone_number, address, 
				  email, passport, specialty, work_experience, 
				  previous_work = nil, previous_post = nil, previous_salary = nil)

		@name = get_name name
		@birthday = birthday
		@phone_number = get_rus_number phone_number
		@address = address
		@email = get_email_downcase email
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

	private :is_rus_number?, :get_rus_number, :is_email?, :get_email_downcase, :is_name?, :get_name
end


first_emp = Employee.new("    Толстиков    Илья Вадимович   ", "22.12.1999", "89183616209", "Odesskay 44", "Henuhi86@gmail.com", 
	"0555 239999", "Programmer", 3, "Gazzprom", "Web", 54000)
second_emp = Employee.new("Салтыков   -   Щедрин Иван-    Руслан    Ахмед    оглы", "22.12.1999", "89183616209", "Oddesskay 44", "Henuhi86@gmail.com", 
	"0555 239999", "Programmer", 0)


puts second_emp.name