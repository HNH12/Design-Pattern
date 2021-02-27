str = gets.chomp

reg = /([1-9]{0}[1-3]{1}[1-9]{1}\s|[1-9]{0}[1-9]{1}\s) (december|january|february|march|april|may|june|july|august|september|october|november) ([1-9]{1}\d*)/
print str.scan(reg)