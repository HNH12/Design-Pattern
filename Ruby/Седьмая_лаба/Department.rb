require_relative 'Post_list'


class Department
  def initialize(department_name)
    self.department_name = department_name
  end

  def department_name=(department_name)
    @department_name = department_name
  end

  def department_name
    @department_name
  end

  def post_list=(post_list)
    @post_list = post_list
  end

  def post_list
    @post_list
  end

  def read_DB
    @client = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'root',
      :database => 'stuff'
    )

    department_id = @client.query("SELECT DepartmentID FROM departments WHERE DepartmentName = '#{self.department_name}'")

    results = []
    department_id.each do |field|
      results = @client.query("SELECT * FROM post WHERE DepartmentID = #{field['DepartmentID']}")
    end

    results.each do |row|
      fixed_premium = row['FixedPremiumSize']
      quarterly_award = row['QuarterlyAwardSize']
      possible_bonus = row['PossibleBonusPercent']

      self.post_list.add(Post.new(row['PostName'], row['FixedSalary'], fixed_premium, quarterly_award, possible_bonus))
    end
  end
end

# test_dep = Department.new 'Отдел кадров'
#
# test_post_list = Post_list.new test_dep
# test_post = Post.new('Программист', 40000, 10000, 3000, 50)
#
# test_post_list.add test_post
#
# test_dep.post_list =test_post_list
#
# puts test_dep.post_list.choose(0).get_full_info

# test_dep = Department.new 'Отдел кадров'
# test_dep.post_list = Post_list.new test_dep
#
# test_dep.read_DB
#
# puts test_dep.post_list.choose(0).get_full_info