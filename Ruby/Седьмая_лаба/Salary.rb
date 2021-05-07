class Salary
  def initialize
    @salary = 0.to_f
  end

  def get_salary
    @salary
  end

  def self.empty_salary
    @salary
  end

  def self.possible_bonus_with_quarterly_award(size_fixed_salary, size_award, size_bonus)
    PossibleBonus.new(QuarterlyAward.new(FixedSalary.new(Salary.new, size_fixed_salary), size_award), size_bonus)
  end

  def self.fixed_premium(size_fixed_salary, size_premium)
    FixedPremium.new(FixedSalary.new(Salary.new, size_fixed_salary), size_premium)
  end
end

class Decorator < Salary
  def initialize(component, size_salary)
    @component = component
    @size_salary = size_salary
  end

  def get_salary
    @component.get_salary
  end
end

class FixedSalary < Decorator
  def get_salary
    super + @size_salary
  end
end

class FixedPremium < Decorator
  def get_salary
    super + @size_salary
  end
end

class Quarterly_award < Decorator
  def get_salary
    super + @size_salary
  end
end

class Possible_bonus < Decorator
  def get_salary
    super * (1 + @size_salary/100.to_f)
  end
end


# salary = Salary.new
#
# puts salary.get_salary
#
# salary = FixedSalary.new(salary,100)
#
# puts salary.get_salary
#
# salary = FixedSalary.new(salary, 12)
#
# puts salary.get_salary()
#
# salary = PossibleBonus.new(salary, 50)
#
# puts salary.get_salary
