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

	def self.write_to_file(file_path)
		File.open(file_path, 'w:UTF-8') do |file| 
			@@list_employee.each do |user| 
				passport_cipher = @@keypair.public_encrypt(user.passport.to_s)
				file.write(user.name.to_s + '|||' + user.birthday.to_s + '|||' + user.phone_number.to_s + '|||' +
					+ user.address.to_s + '|||' + user.email.to_s + '|||' + passport_cipher.force_encoding('UTF-8') + 
					+ '|||' + user.specialty.to_s + '|||' + user.work_experience.to_s)
				if user.work_experience > 0 
					file.write('|||' + user.previous_work + '|||' + user.previous_post + '|||' + user.previous_salary) 
				end
				file.write("\n\n")
			end
		end
	end

	def self.read_from_file(file_path)
		File.open(file_path, 'r:UTF-8') do |file|
			users = file.read
			users = users.force_encoding('windows-1251')
			users = users.split("\n\n")
			users.each do |user|
				user = user.split('|||')
				puts "#{user}"
				data_passport = @@keypair.private_decrypt(user[5])
				if user[7].to_i > 0
					@@list_employee.append(Employee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i, user[8], user[9], user[10]))
				else
					@@list_employee.append(Employee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i))
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