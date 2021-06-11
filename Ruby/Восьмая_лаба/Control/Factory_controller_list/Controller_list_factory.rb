class Controller_list_factory
  def create_controller_list
    list, c, v = create_params
    c.set_view(v)
    list.read_db
    c.set_model(list)
    return c
  end

  def create_params
    return list, c, v
  end

end
