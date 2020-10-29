require 'csv'

def display_option_menu
  puts ''
  puts '請選擇以下選項：'
  puts ''
  puts '輸入 1 建立配件資訊: '
  puts '輸入 2 讀取配件資訊: '
  puts '輸入 3 更新配件資訊: '
  puts '輸入 4 刪除配件資訊: '
  puts '輸入 5 搜尋配件資訊: '
  puts '輸入 6 以售價查詢配件資訊: '
  puts '輸入 7 讀取系統內所有電腦配件資料: '
  puts '請輸入 exit 結束系統: '
  puts ''
  print '請選擇以下選項： '
end

def display_create_option
  puts ''
  puts '您選擇了建立資料的選項'
  puts ''
  print '請輸入CPU規格名稱: '
    cpu_input = gets.chomp
    cpu_title = validator('CPU', cpu_input)
  print '請輸入CPU費用: '
    cpu_price_input = gets.chomp
    cpu_price = validator('CPU Price', cpu_price_input)
  print '請輸入滑鼠規格名稱: '
    mouse_input = gets.chomp
    mouse_title = validator('Mouse', mouse_input)
  print '請輸入滑鼠費用: '
    mouse_price_input = gets.chomp
    mouse_price = validator('Mouse Price', mouse_price_input)
  print '請輸入鍵盤規格名稱: '
    keyboard_input = gets.chomp
    keyboard_title = validator('Keyboard', keyboard_input)
  print '請輸入鍵盤費用: '
    keyboard_price_input = gets.chomp
    keyboard_price = validator('Keyboard Price', keyboard_price_input)

    ds = DS.new(cpu_title, cpu_price, mouse_title, mouse_price ,keyboard_title, keyboard_price)
    ds.create
end

def display_read_option
  puts ''
  puts '您選擇了讀取配件資訊的選項'
  puts ''
  print '請輸入要讀取的電腦ID: '
  id_input = gets.chomp
  computer_id = validator('Computer ID', id_input)
  DS.show(computer_id)
end

def display_update_option
  puts ''
  puts '您選擇了更新配件資訊的選項'
  puts ''
  print '請輸入要讀取的電腦ID: '
    id_input = gets.chomp
    computer_id = validator('Computer ID', id_input)
  print '請輸入CPU規格名稱: '
    cpu_input = gets.chomp
    cpu_title = validator('CPU', cpu_input)
  print '請輸入CPU費用: '
    cpu_price_input = gets.chomp
    cpu_price = validator('CPU Price', cpu_price_input)
  print '請輸入滑鼠規格名稱: '
    mouse_input = gets.chomp
    mouse_title = validator('Mouse', mouse_input)
  print '請輸入滑鼠費用: '
    mouse_price_input = gets.chomp
    mouse_price = validator('Mouse Price', mouse_price_input)
  print '請輸入鍵盤規格名稱: '
    keyboard_input = gets.chomp
    keyboard_title = validator('Keyboard', keyboard_input)
  print '請輸入鍵盤費用: '
    keyboard_price_input = gets.chomp
    keyboard_price = validator('Keyboard Price', keyboard_price_input)

    computer = DS.read(computer_id)
    computer.cpu_title = cpu_title
    computer.cpu_price = cpu_price
    computer.mouse_title = mouse_title
    computer.mouse_price = mouse_price
    computer.keyboard_title = keyboard_title
    computer.keyboard_price = keyboard_price
    computer.update
end

def display_delete_option
  puts ''
  puts '你選擇了刪除電腦配件紀錄'
  puts ''
  print '請輸入電腦ID: '
  id_input = gets.chomp
  computer_id = validator('Computer ID', id_input)
  print "請輸入 (Y or y) 確認刪除電腦ID-#{computer_id} 檔案: "
  confirm_input = gets.chomp
  confirm = validator('Input', confirm_input).downcase
  if confirm == 'y'
    DS.destroy(computer_id)
  end
end

def display_price_search
  puts ''
  puts '你選擇了篩檢配件售價'
  puts ''
  print '請輸入電腦ID進行搜索: '
  search_input = gets.chomp
  file_name = validator('Id', search_input)
  puts ''
  print '請輸入售價: '
  price_input = gets.chomp
  price_target = validator('Price', price_input)
  search_price(file_name, price_target)
end

def search_price(input_id, input_price)
  filename = "ID-#{input_id}.csv"
  if File.exist?(filename)
    ds = DS.new
    computer = Computer.new(input_id, input_price, ds)
    p computer.cpu
    p computer.mouse
    p computer.keyboard
  else
    puts ''
    puts "#{filename} file is not in the system"
  end
end

def display_search_option
  puts ''
  puts '你選擇了搜尋電腦配件檔案'
  puts ''
  print '請輸入電腦ID進行搜索: '
  search_input = gets.chomp
  file_name = validator('Id', search_input)
  search_file(file_name)
end

def search_file(input_id)
  filename = "ID-#{input_id}.csv"
  if File.exist?(filename)
    CSV.open(filename, 'r') do |csv|
      data_line = csv.read.flatten
      puts ''
      puts "CPU: #{data_line[0]} with price of #{data_line[1]}"
      puts "Mouse: #{data_line[2]} with price of #{data_line[3]}"
      puts "Keyboard: #{data_line[4]} with price of #{data_line[5]}"
    end
  else
    puts ''
    puts "#{filename} file is not in the system"
  end
end

def display_file_index
  matching_files = Dir["ID-*.csv"]
  puts ""
  puts "檔案名稱       CPU         CPU費用    滑鼠        滑鼠費用     鍵盤       鍵盤費用"

  matching_files.each do |file|
      display_CSV_data(file)
    end
end

def display_CSV_data(file)
  CSV.open(file,'r') do |csv|
    data_line = csv.read.first
    cpu_title = data_line[0]
    cpu_price = data_line[1]
    mouse_title = data_line[2]
    mouse_price = data_line[3]
    keyboard_title = data_line [4]
    keyboard_price = data_line [5]

    if cpu_title.length < 12
      space_count = 12 - cpu_title.length
      cpu_title = cpu_title + " " * space_count
    end
    if cpu_price.length < 8
      space_count = 8 - cpu_price.length
      cpu_price = cpu_price + " " * space_count
    end
    if mouse_title.length < 8
      space_count = 8 - mouse_title.length
      mouse_title = mouse_title + " " * space_count
    end
    if mouse_price.length < 8
      space_count = 8 - mouse_price.length
      mouse_price = mouse_price + " " * space_count
    end
    if keyboard_title.length < 8
      space_count = 8 - keyboard_title.length
      keyboard_title = keyboard_title + " " * space_count
    end
    print "#{file}"
    print "    #{cpu_title}"
    print "$#{cpu_price}"
    print "  #{mouse_title}"
    print "    $#{mouse_price}"
    print "    #{keyboard_title}"
    print "   $#{keyboard_price}"
    puts ""
  end
end

def validator(field_name, input)
  while input.length == 0 do
    puts "#{field_name} 不能空白，請再次輸入一次"
    input = gets.chomp
  end
  return input
end