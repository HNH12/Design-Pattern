require 'openssl'

keypair = OpenSSL::PKey::RSA.new File.read('certificate.pem')

# z = keypair.public_encrypt('7766559876')
# File.write('input.txt', z)

file = File.read('input.txt')

r = keypair.private_decrypt(file)

puts r

