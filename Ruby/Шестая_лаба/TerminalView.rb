require 'openssl'
require_relative 'TestEmployee.rb'
require_relative 'Employee.rb'
require_relative 'ListEmployee.rb'
require 'mysql2'
require_relative 'Validate.rb'


class TerminalViewListEmployee
	@@list_employee = ListEmployee.new()
	@@client = Mysql2::Client.new(
		:host => 'localhost',
		:username => 'root',
		:database => 'stuff'
	)


	def self.set_client(host, username, database)
		@@client = Mysql2::Client.new(
			:host => host,
			:username => username,
			:database => database
		)
	end

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

	def self.read_list_DB
		@@list_employee.read_list_DB
	end

	def self.write_to_file(file_path)
		@@list_employee.write_to_file file_path
	end

	def self.write_to_YAML(file_path)
		@@list_employee.write_list_YAML file_path
	end

	def self.read_YAML(file_path)
		@@list_employee.read_list_YAML file_path
	end

	def self.read_JSON(file_path)
		@@list_employee.read_list_JSON file_path
	end

	def self.write_JSON(file_path)
		@@list_employee.write_list_JSON file_path
	end

	def self.show_list
		@@list_employee.to_s
	end

	def self.append_to_DB
		emp = Employee.new('Иванов Иван Иванович','21.12.2001', '89183667269', 'Одесская 22',
											 'ggggg23@gmail.com', '2222334455', 'Сварщик', '0')
		@@list_employee.add_to_DB(emp)
	end

	def self.try_connect
		begin
			list_serialized = ListEmployee.new
			list_serialized.read_list_YAML 'list_employee.yaml'

			@@connection = WorkWithDB.new(@@list_employee)
			@@connection.read_list_DB

			check = compare_data(@@list_employee, list_serialized)
			if check == false
				ans = ''
				while ans != '0'
					puts 'Записи в базе данных и в сериализованном файле не совпадают. Какой вариант вам предпочтительнее?',
							 '1. Данные из БД', '2. Данные из файла'
					print 'Ответ: '
					ans = gets.chomp
					case ans
					when '1'
						@@list_employee.write_list_YAML 'list_employee.yaml'
						puts 'Работаем с БД'
						ans = '0'
					when '2'
						@@list_employee = list_serialized
						@@connection.update_DB(list_serialized)
						puts 'Работаем с файлом'
						ans = '0'
					else
						puts 'Такого пункта нет'
					end
				end
			end
		rescue Mysql2::Error
			ans = ''
			while ans != '1'
				puts 'Подключение к базе невозможно.', '1. Прочитать данные из сериализованного файла.', '2. Завершить работу.'
				print 'Ответ: '
				ans = gets.chomp
				case ans
				when '1'
					@@list_employee.read_list_YAML 'list_employee.yaml'
				when '2'
					exit
				else
					puts 'Такого пункта нет'
				end
			end
		end
	end

	def self.find(data)
		emp = @@list_employee.find_emp(data)
		if emp == []
			puts 'Неверные данные'
		else
			emp
		end
	end

	def self.change_node(value)
		needed_emp = @@list_employee.find_emp value
		@@list_employee.change_node needed_emp
	end

	def self.delete_from_db(value)
		needed_emp = @@list_employee.find_emp value
		@@list_employee.delete_from_db needed_emp
	end

	def self.close_app
		exit(0)
	end
end