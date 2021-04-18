require_relative 'Employee.rb'


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

	def read_from_file(file_path)
		File.open(file_path, 'r:UTF-8') do |file|
			users = file.read
			users = users.force_encoding('windows-1251')
			users = users.split("\n\n")
			users.each do |user|
				user = user.split('|||')
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

	def to_s
		str = ""
		@new_list.each { |el| str += "\n\n#{el.get_full_info}"}
		str
	end

	def sort field
		eval "list_employee.sort! { |a, b| a.#{field} <=> b.#{field} }"
	end
end