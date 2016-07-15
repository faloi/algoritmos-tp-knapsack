class Knapsack::Solution
  include Comparable
  attr_reader :instance, :items, :value, :remaining_capacity, :solver

  def initialize(solver, instance, items)
    @solver = solver
    @instance = instance
    @items = items
    @value = items.sum &:gain
    @remaining_capacity = instance.capacity - items.sum(&:weight)
  end

  def to_s
  %{
Solution for #{instance.name} using #{solver.name} solver...
#{solver.info instance}
Capacity: #{instance.capacity} / Value: #{value} / Optimal: #{instance.optimal_value} (#{distance_to_optimal.round 2}% better) / Remaining: #{remaining_capacity}
Items: #{items.map(&:number)}
  }
  end

  def distance_to_optimal
    (instance.optimal_value - value.to_f) / instance.optimal_value * 100
  end

  def <=>(other)
    value <=> other.value
  end

  def self.empty(solver, instance)
    self.new solver, instance, []
  end
end
