require 'openssl'
require_relative 'TestEmployee.rb'
require_relative 'Employee.rb'
require_relative 'ListEmployee.rb'


class TerminalViewListEmployee
	@@list_employee = ListEmployee.new()
	

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
					@@list_employee.append(Employee.new(name, date, phone, address, email, passport, specialty, work_experience, 
						previous_work, previous_post, previous_salary))
					is_not_appended = false
				end

			rescue => e
				puts 'Неверный тип аргумента'
			end
		end
	end

	def self.read_from_file(file_path)
		@@list_employee.read_from_file file_path
	end

	def self.show_list
		puts @@list_employee
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

	# def self.change_employee 
	# 	check = true
	# 	while check
	# 		puts 'Введите паспорт сотрудника'
	# 		begin
	# 			passport = Employee.get_passport gets.chomp
	# 			(Employee.return_employee_by_passport).each do 
	# 				puts 'Что вы хотите изменить у пользователя?'
	# 				puts '1) ФИО','2) Телефон', '3) Email', '4) Паспорт', '5) Специальность', '6) Опыт работы'
	# 				choose = gets.chomp
					
	# 			end
	# 			check = false
	# 		rescue => e
	# 			e.message
	# 		end
	# 	end
	# end

	def close_app
		exit(0)
	end


	# when '7'
	# 			puts "\tПо какому полю вы хотите отсортировать?", "\t1. ФИО.", "\t2. Дата рождения.", 
	# 				"\t3. Телефон.", "\t4. E-mail.", "\t5. Паспорт.", 
	# 				"\t6. Специальность.", "\t7. Опыт работы."
	# 			print "\tОтвет: "
	# 			ans_sort = gets.chomp
	# 			case ans_sort
	# 			when '1'
	# 				@@list_employee.sort 'fio'
	# 			when '2'
	# 				@@list_employee.sort 'datebirth'
	# 			when '3'
	# 				@@list_employee.sort 'phone_number'
	# 			when '4'
	# 				@@list_employee.sort 'e_mail'
	# 			when '5'
	# 				@@list_employee.sort 'passport'
	# 			when '6'
	# 				@@list_employee.sort 'specialty'
	# 			when '7'
	# 				@@list_employee.sort 'work_experience'
	# 			else
	# 				puts "\tТакого пункта нет"
	# 			end
	# 			puts
	# 		when '0'
	# 			close_app
	# 		else
	# 			puts 'Такого пункта нет'
	# 		end
end