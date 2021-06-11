class Terminal_view_instance
  def initialize(controller)
    @controller = controller
  end

  def template
    show
    save
    check
    close
  end

  def show
    raise ArgumentError
  end

  def save

  end

  def check

  end

  def close
    @controller.close_view
  end
end
