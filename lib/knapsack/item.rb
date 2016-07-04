class Knapsack::Item
  attr_reader :weight, :gain

  def initialize(weight, gain)
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
