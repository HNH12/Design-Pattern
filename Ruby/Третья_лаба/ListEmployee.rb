require_relative 'Employee.rb'


class ListEmployee
	def initialize()
		@new_list = []
	end

	def append(user)
		@new_list << user
	end

	def new_list
		@new_list
	end

	def each(&block)
		@new_list.each { |el| block.call(el)}
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