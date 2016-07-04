class Knapsack::Item
  attr_reader :number, :weight, :gain

  def initialize(number, weight, gain)
    @number = number
    @weight = weight
    @gain = gain
  end

  def ==(other)
    other.class == self.class && other.state == self.state
  end

  def state
    self.instance_variables.map { |variable| self.instance_variable_get variable }
  end
end
