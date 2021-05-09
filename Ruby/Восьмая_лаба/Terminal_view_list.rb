class Terminal_view_list
  def initialize(list)
    @list = list
  end

  def template
    show_view
    show_list
    choose_instance('test')
    show_instance
    change_instance
    delete_instance
    close
  end

  def show_view
    raise ArgumentError
  end

  def show_list
    raise ArgumentError
  end

  def choose_instance(number)
    raise ArgumentError
  end

  def show_instance
    raise ArgumentError
  end

  def change_instance
    raise ArgumentError
  end

  def delete_instance
    raise ArgumentError
  end

  def close
    raise ArgumentError
  end
end
