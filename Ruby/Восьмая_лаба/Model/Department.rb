require_relative 'Post_list'


class Department
  attr_accessor :department_name, :department_id

  def initialize(department_name, department_id)
    self.department_id = department_id
    self.department_name = department_name
  end

  def post_list=(post_list)
    @post_list = post_list
  end

  def post_list
    @post_list
  end

  def delete_post post_num
    @post_list.post_list.each do |post|
      if post.id == post_num
        @post_list.delete post
        DB_work.DB_connection.delete_post post
      end
    end
  end

  def add(post)
    @post_list.add post
  end

  def read_DB
    @post_list = Post_list.new self
    @post_list.read_DB
  end

  def to_s
    "#{self.department_id} #{self.department_name}"
  end
end