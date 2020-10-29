require_relative 'DS'
require 'benchmark'

class Computer
  def initialize(computer_id, target_price, data_source)
    @id = computer_id
    @target_price = target_price
    @data_source = data_source
    data_source.methods.grep(/^get_(.*)_info$/) { Computer.define_component $1 }
  end

  def self.define_component(title)
      define_method(title) do
      info = @data_source.send("get_#{title}_info", "#{@id}")
      price = @data_source.send("get_#{title}_price", "#{@id}")
      result = "#{title.capitalize}: #{info} ($#{price})"
      return "* 太貴囉！ * #{result}" if price >= @target_price.to_f
      result
    end
  end
end
