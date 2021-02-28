def get_possible_solutions(perimeter)
	possible_perimeters = 0
	for side_a in 1..perimeter/2
		for side_b in side_a+1..perimeter/2
			side_c = perimeter - side_a - side_b
			if side_a**2 + side_b**2 == side_c**2
				possible_perimeters += 1
			end
		end
	end
	possible_perimeters
end


def get_max_possible_solutions()
	max_possible_solutions = 0
	max_perimeter = 0
	for perimeter in 1..1001
		current_possible_solutions = get_possible_solutions(perimeter)
		if current_possible_solutions > max_possible_solutions
			max_possible_solutions = current_possible_solutions
			max_perimeter = perimeter
		end
	end
	max_perimeter
end


print get_max_possible_solutions