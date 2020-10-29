require_relative 'computer'
require_relative 'helper'

in_the_system = true
puts ''
puts '歡迎來到電腦庫存管理系統!'
puts '==========================================='

while in_the_system
  display_option_menu
  response = gets.chomp
  if response == 'exit'
    puts '感謝您使用電腦庫存管理系統'
    in_the_system = false
  else
    case response
    when '1'
      display_create_option
    when '2'
      display_read_option
    when '3'
      display_update_option
    when '4'
      display_delete_option
    when '5'
      display_search_option
    when '6'
      display_price_search
    when '7'
      display_file_index
    else
      puts ''
      puts '這不是有效的選項，請重新輸入'
    end
  end
end