arr = ['синий', 'белый', 'красный']

z =  arr.sort do |a,b|
	 a.length > b.length ? 1 : a > b ? 1 : -1
end

print z