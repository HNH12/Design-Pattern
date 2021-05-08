class Terminal_view_list
  def initialize(list)
    @list = list
  end

  def template
    show_view
    show_list
    close
  end

  def show_view
    raise ArgumentError
  end

  def show_list
    raise ArgumentError
  end

  def close
    raise ArgumentError
  end
end
