class New_obj
	def initialize(value)
		self.value = value
	end

	def to_s
		return @value.to_s
	end

	def value=(user_value)
		@value = user_value
	end

	def value
		return @value
	end

	def ==(obj)
		return @value == obj.value
	end
end


first_obj = New_obj.new(5)
second_obj = New_obj.new(5)


puts first_obj == second_obj