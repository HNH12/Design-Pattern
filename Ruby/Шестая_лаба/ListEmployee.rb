require_relative 'Employee.rb'
require_relative 'WorkWithDB.rb'
require 'mysql2'
require 'openssl'
require 'yaml'
require 'json'


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

	def read_list_YAML file_name
		@new_list = YAML::load(File.open(file_name))
	end

	def write_list_YAML file_name
		File.open(file_name, 'w:UTF-8') do |file|
			file.puts(@new_list.to_yaml)
		end
	end

	def read_list_JSON file_name
		File.open(file_name, 'r:UTF-8') do |file|
			data = JSON.parse(file.read)
			data.each do |key, value|
				if value["work_experience"] > 0
					emp = Employee.new(value["name"], value["birthday"], value["phone_number"], value["address"],
														 value["email"], value["passport"], value["specialty"], value["work_experience"],
														 value["previous_work"], value["previous_post"], value["previous_salary"])
				else
					emp = Employee.new(value["name"], value["birthday"], value["phone_number"], value["address"],
														 value["email"], value["passport"], value["specialty"], value["work_experience"])
				end
				add_user(emp)
			end
		end
	end

	def write_list_JSON file_name
		File.open(file_name,"w:UTF-8") do |file|
			tempHash = {}
			@new_list.each_with_index do |emp, ind|
				tempHash[ind] = {
					"name": emp.name,
					"birhtday": emp.birthday,
					"phone_number": emp.phone_number,
					"address": emp.address,
					"email": emp.email,
					"passport": emp.passport,
					"specialty": emp.specialty,
					"work_experience": emp.work_experience,
					"previous_work": emp.previous_work,
					"previous_post": emp.previous_post,
					"previous_salary": emp.previous_salary
				}
			end
			file.write(JSON.pretty_generate(tempHash))
		end
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

	def read_list_DB()
		@new_list = DB_work.DB_connection.read_db

	end

	def to_s
		str = ""
		@new_list.each { |el| str += "\n\n#{el.get_full_info}"}
		str
	end

	def add_to_DB(emp)
		DB_work.DB_connection.add_to_DB(emp)
	end

	def change_node(all_emp)
		DB_work.DB_connection.change_node all_emp
	end

	def delete_from_db(all_emp)
		DB_work.DB_connection.delete_from_db all_emp
	end

	def sort field
		eval "list_employee.sort! { |a, b| a.#{field} <=> b.#{field} }"
	end

	def find_emp(info)
		return @new_list.select {|emp| [emp.name, emp.email, emp.phone_number, emp.passport].include? info}
	end
end