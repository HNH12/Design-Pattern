require 'openssl'
require_relative 'TestEmployee.rb'
require_relative 'Employee.rb'
require_relative 'ListEmployee.rb'
require_relative 'Validate.rb'


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
				
				if !Validate.is_employee?(name, date, phone, address, email, passport, specialty, work_experience)
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

	def self.write_to_file(file_path)
		@@list_employee.write_to_file file_path
	end

	def self.show_list
		@@list_employee.to_s
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

	def close_app
		exit(0)
	end
end