require_relative 'Terminal_view_instance'

class Terminal_view_department_instance < Terminal_view_instance
  def show
    ans = ''
    while ans != '0'
      puts
      puts '1. Вывести отдел.',
           '2. Отобразить все должности.',
           '3. Добавить должность',
           '4. Удалить должность',
           '5. Показать всех сотрудников',
           '0. Назад'
      print 'Введите ответ:'
      ans = gets.chomp
      case ans
      when '1'
        print 'Текущий отдел: '
        puts @controller.instance
      when '2'
        show_list
      when '3'
        add_post
      when '4'
        delete_post
      when '5'
        show_employee_list
      when '0'
        break
      else
        'Такого пункта нет'
      end
    end
  end

  def show_employee_list
    @controller.show_employee_list
  end

  def show_list
    puts @controller.show_list
  end

  def add_post
    print 'Введите название должности: '
    post_name = gets.chomp
    print 'Введите фиксированную зарплату: '
    fixed_salary = gets.chomp.to_i
    print 'Введите ежемесячную фиксированную премию: '
    fixed_premium = gets.chomp.to_i
    print 'Введите ежеквартальную премию: '
    quarterly_award = gets.chomp.to_i
    print 'Введите бонус к зарплате ежжи: '
    possible_bonus = gets.chomp.to_i

    @controller.add_post post_name, fixed_salary, fixed_premium, quarterly_award, possible_bonus
  end

  def delete_post
    print('Введите номер: ')
    post_num = gets.chomp.to_i
    @controller.delete_post post_num
  end
end