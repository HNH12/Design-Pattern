require 'mysql2'
require_relative 'Employee.rb'
require_relative 'ListEmployee.rb'


client = Mysql2::Client.new(
  :host => "localhost",
  :username => "root",
  :database => "stuff"
)

def test_select(client)
  results = client.query("SELECT * FROM employees")
  list_emp = ListEmployee.new()
  results.each do |row|
    list_emp.append(Employee.new(row['Name'], row['Birthday'].to_s, row['PhoneNumber'], row['Address'],
      row['Email'], row['Passport'].to_s, row['Specialty'], row['WorkExperience'],
      row['PreviousWork'], row['PreviousPost'], row['PreviousSalary']))
  end
  list_emp
end


puts (test_select client)