def read_file(path) 
	file = File.open(path)
	lines = []
	file.each do |line|
		lines.push(line.chomp)
	end
	file.close
	lines
end


path = "file.txt"
lines = read_file(path)


print lines.sort {|first, second| first.split(%r{[\s!,.-?]+}).size <=> second.split(%r{[\s!,.-?]+}).size}