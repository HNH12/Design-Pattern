months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

day = 2
sunday_count = 0

for year in 1901..2001
	for month in months
		day += month
		if year % 4 == 0 && month == 28 && year % 100 != 0 || year % 400 == 0
                day += 1
        end
        if day % 7 == 0
            sunday_count += 1
        end
	end
end

print sunday_count