require_relative 'Validate.rb'



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


if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

first_obj = New_obj.new(5)
second_obj = New_obj.new(5)

a = [1,2,3]

b = a.select {|el| el == 2}

puts a, b