require_relative 'Clients.rb'
require 'openssl'


class ListClients
	def initialize()
		@new_list = []
		@keypair = OpenSSL::PKey::RSA.new File.read('certificate.pem')
	end

	def append(user)
		@new_list << user
	end

	def new_list
		@new_list
	end

	def write_to_file(file_path)
		File.open(file_path, 'w:UTF-8') do |file| 
			@new_list.each do |user| 
				passport_cipher = @keypair.public_encrypt(user.passport.to_s)
				file.write(user.name.to_s + '|||' + user.phone_number.to_s + '|||' + passport_cipher.force_encoding('UTF-8') 
				file.write("\n\n")
			end
		end
	end

	def read_from_file(file_path)
		File.open(file_path, 'r:UTF-8') do |file|
			users = file.read
			users = users.force_encoding('iso-8859-1')
			users = users.split("\n\n")
			users.each do |user|
				user = user.split('|||')
				user.map! { |el|  el.force_encoding('utf-8')}
				data_passport = @keypair.private_decrypt(user[2])
				@new_list.append(Clients.new(user[0], user[1], user[2]))
			end
		end
	end

	def to_s
		str = ""
		@new_list.each { |el| str += "\n\n#{el.get_full_info}"}
		str
	end

	def sort field
		eval "new_list.sort! { |a, b| a.#{field} <=> b.#{field} }"
	end

	def find_clients(info)
		@new_list.select {|cl| [cl.name, cl.phone_number, cl.passport].include? info}
	end
end