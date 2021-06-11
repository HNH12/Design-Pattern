require_relative 'Salary'
require_relative 'Employee'


class Post
  attr_accessor :id, :post_name, :fixed_salary, :fixed_premium, :quarterly_award,
                :possible_bonus_percent, :salary,:department

  def initialize(id, post_name, fixed_salary, fixed_premium, quarterly_award, possible_bonus_percent, department)
    self.id = id
    self.post_name = post_name
    self.fixed_salary = fixed_salary
    self.fixed_premium = fixed_premium
    self.quarterly_award = quarterly_award
    self.possible_bonus_percent = possible_bonus_percent
    self.salary = Salary.new
    self.department = department
  end

  def employee=(emp)
    @employee = emp
    @employee.post = self
  end

  def employee
    @employee.get_full_info
  end

  def to_s
    "#{self.id},#{self.post_name}, #{self.fixed_salary}, #{self.fixed_premium},
      #{self.quarterly_award}, #{self.possible_bonus_percent}"
  end
end


# test_emp = Employee.new('Иванов Иван Иванович', '12.12.2000', '89181112233', 'Московская 4',
#                    'ivanov99@mail.ru', '1111334455', 'Программист', '0')
#
# post = Post.new('Программист', 40000, 10000, 3000, 50)
# post.employee = test_emp
#
# puts post.employee