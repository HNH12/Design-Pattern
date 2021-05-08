require_relative 'Employee.rb'
require_relative 'Post'
require 'mysql2'


class DB_work
  @@DB_connection = nil
  # private_class_method :new

  def initialize
    @client = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'root',
      :database => 'stuff'
    )
  end

  def self.DB_connection
    if @@DB_connection == nil
      @@DB_connection = DB_work.new
    end
    @@DB_connection
  end

  def add_to_DB(emp)
    emp_previous_work = emp.previous_work == 'Поле не указано' ? nil : emp.previous_work
    emp_previous_post = emp.previous_post == 'Поле не указано' ? nil : emp.previous_post
    emp_previous_salary = emp.previous_salary == 'Поле не указано' ? nil : emp.previous_salary

    if emp_previous_salary == nil || emp_previous_post == nil || emp_previous_work == nil
      @client.query("INSERT INTO `stuff`.`employees` (`Name` ,`Birthday` ,`PhoneNumber` ,`Address` ,`Email` ,
														`Passport` ,`Specialty` ,`WorkExperience`)
													VALUES ('#{emp.name}', '#{emp.birthday}', '#{emp.phone_number}', '#{emp.address}', '#{emp.email}',
														'#{emp.passport}', '#{emp.specialty}', #{emp.work_experience.to_i})")
    else
      @client.query("INSERT INTO `stuff`.`employees` (`Name` ,`Birthday` ,`PhoneNumber` ,`Address` ,`Email` ,
														`Passport` ,`Specialty` ,`WorkExperience`, `PreviousWork` ,`PreviousPost` ,`PreviousSalary`)
													VALUES ('#{emp.name}', '#{emp.birthday}', '#{emp.phone_number}', '#{emp.address}', '#{emp.email}',
														'#{emp.passport}', '#{emp.specialty}', #{emp.work_experience.to_i},
														'#{emp_previous_work}', '#{emp_previous_post}', #{emp_previous_salary})")
    end
  end

  def change_node(all_emp)
    all_emp.each { |emp|
      emp_previous_work = emp.previous_work == 'Поле не указано' ? nil : emp.previous_work
      emp_previous_post = emp.previous_post == 'Поле не указано' ? nil : emp.previous_post
      emp_previous_salary = emp.previous_salary == 'Поле не указано' ? nil : emp.previous_salary
      emp.name = 'Толстиков Илья Вадимович'
      if emp_previous_salary == nil || emp_previous_post == nil || emp_previous_work == nil
        @client.query("UPDATE employees SET Name = '#{emp.name}'
										WHERE Passport = '#{emp.passport}'")
      else
        @client.query("UPDATE employees SET Name = '#{emp.name}'
										WHERE Passport = '#{emp.passport}'")
      end
    }
  end

  def delete_from_db(all_emp)
    all_emp.each { |emp| emp
      @client.query("DELETE FROM employees WHERE Passport = '#{emp.passport}'")
    }
  end

  def read_db
    new_list = []
    @client.query("SELECT * FROM employees").each do |row|
    	new_list.append(Employee.new(row['Name'], row['Birthday'].to_s, row['PhoneNumber'], row['Address'],
    						 row['Email'], row['Passport'].to_s, row['Specialty'], row['WorkExperience'],
    						 row['PreviousWork'], row['PreviousPost'], row['PreviousSalary']))
    end
    new_list
  end

  def post_list_read_db(department_name)
    new_list= []

    if department_name != nil
      department_id = @client.query("SELECT DepartmentID FROM departments WHERE DepartmentName = '#{department_name}'")

      results = []
      department_id.each do |field|
        results = @client.query("SELECT * FROM post WHERE DepartmentID = #{field['DepartmentID']}")
      end

      results.each do |row|
        fixed_premium = row['FixedPremiumSize']
        quarterly_award = row['QuarterlyAwardSize']
        possible_bonus = row['PossibleBonusPercent']
        new_list << Post.new(row['PostName'], row['FixedSalary'], fixed_premium, quarterly_award, possible_bonus)
      end
    else
      results = @client.query("SELECT * FROM post")

      results.each do |row|
        fixed_premium = row['FixedPremiumSize']
        quarterly_award = row['QuarterlyAwardSize']
        possible_bonus = row['PossibleBonusPercent']
        new_list << Post.new(row['PostName'], row['FixedSalary'], fixed_premium, quarterly_award, possible_bonus)
      end
    end

    new_list
  end

  def post_id_read_db(post)
    results = @client.query("SELECT PostID FROM post WHERE PostName = #{post}")
  end

  def department_list_read_db
    new_list = []
    results = @client.query("SELECT DepartmentName FROM departments")
    results.each { |obj| new_list.append obj["DepartmentName"] }
    new_list
  end
end