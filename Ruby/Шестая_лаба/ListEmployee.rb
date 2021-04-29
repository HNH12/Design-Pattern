require_relative 'Employee.rb'
require 'mysql2'
require 'openssl'


class ListEmployee
	def initialize()
		@new_list = []
		@keypair = OpenSSL::PKey::RSA.new File.read('certificate.pem')
	end

	def append(user)
		@new_list << user
	end

	def new_list
		@new_list
	end

	def write_to_file(file_path)
		File.open(file_path, 'w:UTF-8') do |file| 
			@new_list.each do |user| 
				passport_cipher = @keypair.public_encrypt(user.passport.to_s)
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

	def read_from_file(file_path)
		File.open(file_path, 'r:UTF-8') do |file|
			users = file.read
			users = users.force_encoding('iso-8859-1')
			users = users.split("\n\n")
			users.each do |user|
				user = user.split('|||')
				user.map! { |el|  el.force_encoding('utf-8')}
				data_passport = @keypair.private_decrypt(user[5])
				if user[7].to_i > 0
					@new_list.append(Employee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i, user[8], user[9], user[10]))
				else
					@new_list.append(Employee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i))
				end
			end
		end
	end

	def read_list_DB(client)
		results = client.query("SELECT * FROM employees")
		list_emp = ListEmployee.new()
		results.each do |row|
			@new_list.append(Employee.new(row['Name'], row['Birthday'].to_s, row['PhoneNumber'], row['Address'],
								 row['Email'], row['Passport'].to_s, row['Specialty'], row['WorkExperience'],
								 row['PreviousWork'], row['PreviousPost'], row['PreviousSalary']))
		end
		list_emp
	end

	def to_s
		str = ""
		@new_list.each { |el| str += "\n\n#{el.get_full_info}"}
		str
	end

	def add_to_DB(client, emp)
		emp_previous_work = emp.previous_work == 'Поле не указано' ? nil : emp.previous_work
		emp_previous_post = emp.previous_post == 'Поле не указано' ? nil : emp.previous_post
		emp_previous_salary = emp.previous_salary == 'Поле не указано' ? nil : emp.previous_salary

		if emp_previous_salary == nil || emp_previous_post == nil || emp_previous_work == nil
			client.query("INSERT INTO `stuff`.`employees` (`Name` ,`Birthday` ,`PhoneNumber` ,`Address` ,`Email` ,
														`Passport` ,`Specialty` ,`WorkExperience`)
													VALUES ('#{emp.name}', '#{emp.birthday}', '#{emp.phone_number}', '#{emp.address}', '#{emp.email}',
														'#{emp.passport}', '#{emp.specialty}', #{emp.work_experience.to_i})")
		else
			client.query("INSERT INTO `stuff`.`employees` (`Name` ,`Birthday` ,`PhoneNumber` ,`Address` ,`Email` ,
														`Passport` ,`Specialty` ,`WorkExperience`, `PreviousWork` ,`PreviousPost` ,`PreviousSalary`)
													VALUES ('#{emp.name}', '#{emp.birthday}', '#{emp.phone_number}', '#{emp.address}', '#{emp.email}',
														'#{emp.passport}', '#{emp.specialty}', #{emp.work_experience.to_i},
														'#{emp_previous_work}', '#{emp_previous_post}', #{emp_previous_salary})")
		end
	end

	def change_node(client, all_emp)
		all_emp.each { |emp|
			emp_previous_work = emp.previous_work == 'Поле не указано' ? nil : emp.previous_work
			emp_previous_post = emp.previous_post == 'Поле не указано' ? nil : emp.previous_post
			emp_previous_salary = emp.previous_salary == 'Поле не указано' ? nil : emp.previous_salary
			emp.name = 'Толстиков Илья Вадимович'
			if emp_previous_salary == nil || emp_previous_post == nil || emp_previous_work == nil
				client.query("UPDATE employees SET Name = '#{emp.name}'
										WHERE Passport = '#{emp.passport}'")
			else
				client.query("UPDATE employees SET Name = '#{emp.name}'
										WHERE Passport = '#{emp.passport}'")
			end
			# ,
			# 	Birthday = '#{emp.birthday}',
			# 		PhoneNumber = '#{emp.phone_number}',
			# 		Address' = #{emp.address}',
			# 	Email = '#{emp.email}',
			# 		Passport = '#{emp.passport}',
			# 		Specialty = '#{emp.specialty}',
			# 		WorkExperience = `#{emp.work_experience.to_i}`,
			# 		PreviousWork = '#{emp_previous_work}',
			# 		PreviousPost = '#{emp_previous_post}',
			# 		PreviousSalary = `#{emp_previous_salary}`,
			# 		Birthday = '#{emp.birthday}',
			# 		PhoneNumber = '#{emp.phone_number}',
			# 		Address' = #{emp.address}',
			# 	Email = '#{emp.email}',
			# 		Passport = '#{emp.passport}',
			# 		Specialty = '#{emp.specialty}',
			# 		WorkExperience = `#{emp.work_experience.to_i}`,
			# 		PreviousWork = '#{emp_previous_work}',
			# 		PreviousPost = '#{emp_previous_post}',
			# 		PreviousSalary = `#{emp_previous_salary}`
		}
	end

	def delete_from_db(client, all_emp)
		all_emp.each { |emp| emp
			client.query("DELETE FROM employees WHERE Passport = '#{emp.passport}'")
		}
	end

	def sort field
		eval "list_employee.sort! { |a, b| a.#{field} <=> b.#{field} }"
	end

	def find_emp(info)
		return @new_list.select {|emp| [emp.name, emp.email, emp.phone_number, emp.passport].include? info}
	end
end