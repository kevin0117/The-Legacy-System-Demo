require 'csv'

class DS
  attr_accessor :cpu_title, :cpu_price, :mouse_title, :mouse_price, :keyboard_title, :keyboard_price, :filename
  attr_reader :computer_id

  def initialize(cpu_title="", cpu_price=0, mouse_title="", mouse_price=0, keyboard_title="", keyboard_price=0, computer_id = rand(1000..9999))
    @cpu_title = cpu_title
    @cpu_price = cpu_price
    @mouse_title = mouse_title
    @mouse_price = mouse_price
    @keyboard_title = keyboard_title
    @keyboard_price = keyboard_price
    @computer_id = computer_id
    @filename = "ID-#{computer_id}.csv"
  end

  def get_cpu_info(input_id)
    filename = "ID-#{input_id}.csv"
    if File.exist?(filename)
      CSV.open(filename, 'r') do |csv|
        data_line = csv.read.flatten
        "#{data_line[0]}"
      end
    else
      puts ''
      puts "#{filename} file is not in the system"
    end
  end

  def get_cpu_price(input_id)
    filename = "ID-#{input_id}.csv"
    if File.exist?(filename)
      CSV.open(filename, 'r') do |csv|
        data_line = csv.read.flatten
        data_line[1].to_f
      end
    else
      puts ''
      puts "#{filename} file is not in the system"
    end
  end

  def get_mouse_info(input_id)
    filename = "ID-#{input_id}.csv"
    if File.exist?(filename)
      CSV.open(filename, 'r') do |csv|
        data_line = csv.read.flatten
        "#{data_line[2]}"
      end
    else
      puts ''
      puts "#{filename} file is not in the system"
    end
  end

  def get_mouse_price(input_id)
    filename = "ID-#{input_id}.csv"
    if File.exist?(filename)
      CSV.open(filename, 'r') do |csv|
        data_line = csv.read.flatten
        data_line[3].to_f
      end
    else
      puts ''
      puts "#{filename} file is not in the system"
    end
  end

  def get_keyboard_info(input_id)
    filename = "ID-#{input_id}.csv"
    if File.exist?(filename)
      CSV.open(filename, 'r') do |csv|
        data_line = csv.read.flatten
        "#{data_line[4]}"
      end
    else
      puts ''
      puts "#{filename} file is not in the system"
    end
  end

  def get_keyboard_price(input_id)
    filename = "ID-#{input_id}.csv"
    if File.exist?(filename)
      CSV.open(filename, 'r') do |csv|
        data_line = csv.read.flatten
        data_line[5].to_f
      end
    else
      puts ''
      puts "#{filename} file is not in the system"
    end
  end

  def save
    save_file = CSV.open(filename, 'w') do |csv|
      csv << [cpu_title, cpu_price, mouse_title, mouse_price, keyboard_title, keyboard_price]
    end
    puts ''
    puts "CPU: #{cpu_title} with price of #{cpu_price}"
    puts "Mouse: #{mouse_title} with price of #{mouse_price}"
    puts "Keyboard: #{keyboard_title} with price of #{keyboard_price}"
    puts ''
    puts "This Computer with ID #{computer_id} was written to the file #{filename}"
    puts ''
    !save_file.nil?
  end

  def create
    if !File.exist?(filename)
      save
      puts "#{filename} file now exists in the system"
    else
      puts ''
      puts "#{filename} file is already created in the system"
    end
  end

  def self.read(computer_id)
    filename = "ID-#{computer_id}.csv"
    CSV.open(filename, 'r') do |csv|
      data_line = csv.read
      return DS.new(data_line[0], data_line[1], data_line[2], data_line[3], data_line[4], data_line[5], computer_id)
    end
  end

  def self.show(computer_id)
    filename = "ID-#{computer_id}.csv"
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

  def update
    if File.exist?(filename)
      save
      puts "#{filename} file is successfully updated"
    else
      puts "Computer-#{computer_id} file cannot be updated"
    end
  end

  def self.destroy(computer_id)
    filename = "ID-#{computer_id}.csv"
    if File.exist?(filename)
      File.delete(filename)
      puts ''
      puts "#{filename} file is successfully destroyed"
    else
      puts ''
      puts "#{filename} file is not in the system"
    end
  end
end