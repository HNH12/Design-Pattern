require_relative 'Employee.rb'
require 'mysql2'


class WorkWithDB
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
end
