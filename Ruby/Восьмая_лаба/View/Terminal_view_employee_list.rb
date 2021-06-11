require_relative 'Terminal_view_list'
require_relative '../Model/ListEmployee'


class Terminal_view_employee_list < Terminal_view_list
  attr_accessor :choose_instance_obj

  def initialize(list)
    super list
  end

  def show
    ans = ''
    while ans != '0'
      puts "--------Меню-------", '1. Добавить нового пользователя.',
           '2. Отобразить список пользователей', '3. Найти пользователя по введенным данным.',
           '4. Изменить конкретного пользователя.', '5. Удалить пользователя.',
           '6. Сохранить изменения в файл.', '7. Сортировать по конкретному полю.', '0. Назад.'
      print 'Ответ: '
      ans = gets.chomp
      case ans
      when '2'
        show_list
        puts
      when '0'
        break
      else
        puts 'Такого пункта нет'
      end
    end
  end

  def show_list
    puts @controller.show_list
  end
end