class Knapsack::Item
  attr_reader :number, :gain, :weight

  def initialize(number, gain, weight)
    @number = number
    @gain = gain
    @weight = weight
  end

  def rate
    gain.to_f / weight.to_f
  end

  def to_s
    (state + [rate]).to_s
  end

  def inspect
    to_s
  end

  def ==(other)
    other.class == self.class && other.state == self.state
  end

  def state
    self.instance_variables.map { |variable| self.instance_variable_get variable }
  end
end
