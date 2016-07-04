class Knapsack::Instance
  attr_reader :name, :items, :capacity, :optimal_value

  def initialize(name, items, capacity, optimal_value)
    @name = name
    @items = items
    @capacity = capacity
    @optimal_value = optimal_value
  end

  def self.from_file(test_code)
    lines = read_instance_file test_code
    self.new test_code, to_items(lines.drop(1).clip), lines.last.to_i, read_optimal_value(test_code)
  end

  private

  def self.to_items(item_lines)
    item_lines.map do |line|
      data = line.split(' ').map(&:to_i)
      Knapsack::Item.new *data
    end
  end

  def self.read_instance_file(test_code)
    File.readlines "tests/test_#{test_code}.in"
  end

  def self.read_optimal_value(test_code)
    position = test_code[0...3].to_i
    File.readlines('tests/opt_values.txt')[position].to_i
  end
end
