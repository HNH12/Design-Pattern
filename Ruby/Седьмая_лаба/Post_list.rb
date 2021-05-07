require_relative 'Post'
require 'mysql2'


class Post_list
  attr_accessor :department, :post_list

  def initialize(department=nil)
    self.department = department
    self.post_list = []
  end

  def add(post)
    self.post_list << post
  end

  def choose(numb)
    self.post_list[numb]
  end

  def read_DB
    @client = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'root',
      :database => 'stuff'
    )

    if self.department != nil
      department_id = @client.query("SELECT * FROM departments WHERE DepartmentName = #{department.department_name}")
      results = @client.query("SELECT * FROM post WHERE DepartmentID = #{department_id}")
      results.each do |row|
        fixed_premium = row['FixedPremiumSize']
        quarterly_award = row['QuarterlyAwardSize']
        possible_bonus = row['PossibleBonusPercent']

        self.post_list << (Post.new(row['PostName'], row['FixedSalary'], fixed_premium, quarterly_award, possible_bonus))
      end
    else
      results = @client.query("SELECT * FROM post")
      results.each do |row|
        fixed_premium = row['FixedPremiumSize']
        quarterly_award = row['QuarterlyAwardSize']
        possible_bonus = row['PossibleBonusPercent']

        self.post_list << (Post.new(row['PostName'], row['FixedSalary'], fixed_premium, quarterly_award, possible_bonus))
      end
    end
  end
end


# department = Department.new
#
# test_post_list = Post_list.new department
# test_post = Post.new('Программист', 40000, 10000, 3000, 50)
#
# test_post_list.add test_post
#
# puts test_post_list.choose(0).get_full_info

# test_list = Post_list.new
#
# test_list.read_DB
#
# puts test_list.choose(0).get_full_info