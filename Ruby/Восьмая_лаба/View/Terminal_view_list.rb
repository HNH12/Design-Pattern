class Terminal_view_list
  def initialize(controller)
    @controller = controller
  end

  def template
    show
    show_view
    choose_instance('test')
    show_instance
    change_instance
    delete_instance
    close
  end

  def show
    raise ArgumentError
  end

  def show_list
    puts @controller.show_list
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
    @controller.close_view
  end
end
