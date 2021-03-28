require 'openssl'
require_relative 'TestEmployee.rb'
require_relative 'Employee.rb'
require_relative 'ListEmployee.rb'


class TerminalViewListEmployee
	@@list_employee = ListEmployee.new()
	@@keypair = OpenSSL::PKey::RSA.new File.read('certificate.pem')

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

				print [Employee.get_name(name), Employee.get_birthday(date), Employee.get_rus_number(phone), address,
				 	Employee.get_email_downcase(email), Employee.get_passport(passport)]

				if [Employee.get_name(name), Employee.get_birthday(date), Employee.get_rus_number(phone), address,
				 	Employee.get_email_downcase(email), Employee.get_passport(passport)].include? nil 
					raise TypeError
				else
					@@list_employee.append(Employee.new(name, date, phone, address, email, passport, specialty, work_experience, 
						previous_work, previous_post, previous_salary))
					is_not_appended = false
				end

			rescue => e
				puts e.message
				puts "Некорректные данные. Введите данные ещё раз"
				print [Employee.get_name(name), Employee.get_birthday(date), Employee.get_rus_number(phone), address,
				 	Employee.get_email_downcase(email), Employee.get_passport(passport)]
			end
		end
	end

	def self.write_to_file(file_path)
		File.open(file_path, 'w:ASCII-8BIT') do |file| 
			@@list_employee.each do |user| 
				passport_cipher = @@keypair.public_encrypt(user.passport)
				file.write(user.name + '|||' + user.birthday + '|||' + user.phone_number + '|||' +
					+ user.address + '|||' + user.email + '|||' + passport_cipher.force_encoding("UTF-8") + 
					+ '|||' + user.specialty + '|||' + user.work_experience.to_s)
				if user.work_experience > 0 
					file.write('|||' + user.previous_work + '|||' + user.previous_post + '|||' + user.previous_salary) 
				end
				file.write("\n\n")
			end
		end
	end

	def self.read_from_file(file_path)
		File.open(file_path) do |file|
			users = file.read
			users = users.force_encoding("UTF-8")
			users = users.split("\n\n")
			users.each do |user|
				user = user.split('|||')
				puts "#{user}"
				data_passport = @@keypair.private_decrypt(user[5])
				if user[7].to_i > 0
					list_employee << Employee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i, user[8], user[9], user[10])
				else
					list_employee << Employee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i)
				end
			end
		end
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