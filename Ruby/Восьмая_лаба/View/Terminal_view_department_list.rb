require_relative '../Model/Department_list'
require_relative '../View/Terminal_view_list'


if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


class Terminal_view_department_list < Terminal_view_list
  attr_accessor :choose_instance_obj

  def show
    ans = ''
    while ans != '0'
      puts "\n************Меню*************",
           '1. Отобразить список отделов',
           '2. Выбрать отдел',
           '3. Отобразить выбранное',
           '4. Добавить отдел',
           '5. Удалить выбранный отдел',
           '0. Завершить работу'
      print 'Ответ:'
      ans = gets.chomp
      case ans
      when '1'
        puts "\n========Отделы======="
        show_list
      when '2'
        print 'Введите номер отдела:'
        num = gets.chomp.to_i
        choose_instance num
      when '3'
        show_instance
      when '4'
        print 'Введите имя: '
        dep_name = gets.chomp
        add dep_name
        puts 'Добавление прошло успешно'
      when '5'
        if @choose_instance_obj != nil
          delete_instance
          puts 'Удаление прошло успешно'
          @choose_instance_obj = nil
        else
          puts 'Вы не выбрали отдел'
        end
      when '0'
        close
      else
        puts 'Такого пункта нет'
      end
    end
  end

  def add(dep_name)
    @controller.add dep_name
  end

  def choose_instance(number)
    self.choose_instance_obj = @controller.choose_instance number
  end

  def show_instance
    puts self.choose_instance_obj
    @controller.show_instance self.choose_instance_obj
  end

  def delete_instance
    @controller.delete choose_instance_obj
  end
end


# test_dep = Department.new 'Отдел кадров'
#
# test_post_list = Post_list.new test_dep
# test_post = Post.new('Программист', 40000, 10000, 3000, 50)
#
# test_post_list.add test_post
#
# test_dep.post_list = test_post_list
#
# test_dep_list = Department_list.new
# test_dep_list.add(test_dep)
#
# # Terminal_view_department_list.new(test_dep).template
# test = Terminal_view_department_list.new test_dep_list
#
# test.choose_instance 0
# puts test.show_instance