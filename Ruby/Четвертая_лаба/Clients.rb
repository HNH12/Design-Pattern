class Clients
	def self.is_rus_number?(new_number)
		new_number.scan(/\d/).size == 11 ? true : false
	end	

	def self.form_rus_number(new_number)
		number = new_number.scan(/\d/)

		"7-" + number[1,3].join('')+"-"+number[4..].join('')
	end

	def self.get_rus_number(new_number)
		is_rus_number?(new_number) ? form_rus_number(new_number): raise(ArgumentError)
	end

	def self.is_name?(new_name)
		regx = /(([А-яё]+\s*-\s*[А-яё]+\s+)|([А-яё]+\s+))(([А-яё]+\s*-\s*[А-яё]+\s+)|([А-яё]+\s+))(([А-яё]+\s+[А-яё]+\s*$)|([А-яё]+\s*$))/
		if (new_name =~ regx) != nil
			true
		else
			false
		end
	end

	def self.get_name(new_name)
		is_name?(new_name) ? new_name.strip().gsub(/(\s{2,})/, ' ').gsub(/\s*-\s*/, '-').gsub(/[А-яё]+/) {|word| word.capitalize} : raise(ArgumentError)
	end

	def self.is_passport?(new_passport)
		(new_passport =~ /(\d{10}|(\d{4}\s\d{6}))/) == 0 ? true : false
	end

	def self.get_passport(new_passport)
		is_passport?(new_passport) ? new_passport.gsub(/(\d{4})(\d{6})/, '\1 \2') : raise(ArgumentError)
	end

	def initialize(name, phone_number, passport)

		self.name = name
		self.phone_number = phone_number
		self.passport = passport
	end

	def phone_number
		@phone_number
	end

	def phone_number=(new_phone_number)
		begin
			@phone_number = Employee.get_rus_number new_phone_number
		rescue => error
			error.message
		end
	end

	def name
		@name
	end

	def name=(new_name)
		begin
			@name = Clients.get_name new_name
		rescue => error
			error.message
		end
	end

	def passport
		@passport
	end

	def passport=(new_passport)
		begin
			@passport = Clients.get_passport new_passport
		rescue => error
			error.message
		end
	end

	def get_full_info
		"#{name}, #{phone_number}, #{passport};\n"
	end
end