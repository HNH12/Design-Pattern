require 'openssl'

keypair = OpenSSL::PKey::RSA.new File.read('certificate.pem')

z = keypair.public_encrypt('афы 3333 445566')
File.open('input.txt', 'w') do |file|
	file.write z
end

puts z

File.open('input.txt', 'r') do |file|
	print keypair.private_decrypt(file.read)
end
