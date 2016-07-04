class Knapsack::Instance
  attr_reader :items, :capacity, :optimal_value

  def initialize(items, capacity, optimal_value)
    @items = items
    @capacity = capacity
    @optimal_value = optimal_value
  end

  def self.from_file(test_code)
    lines = read_file test_code
    self.new to_items(lines.drop(1).clip), lines.last.to_i, 0
  end

  private

  def self.to_items(item_lines)
    item_lines.map do |line|
      data = line.split(' ')
      Knapsack::Item.new data[1].to_i, data[2].to_i
    end
  end

  def self.read_file(test_code)
    File.readlines "tests/test_#{test_code}.in"
  end
end
