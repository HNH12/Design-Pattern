class MainClass
  attr_accessor :field1
  def initialize(field1)
    self.field1 = field1
  end

  def first_method
    field1
  end

  def second_method
    field1 + 2
  end
end

class DelClass
  attr_accessor :field2, :main_class
  include MainClass

  def initialize(field1, field2)
  end

  def first_method
    main
  end
end