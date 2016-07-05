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
Capacity: #{instance.capacity} / Value: #{value} / Optimal: #{instance.optimal_value} / Remaining: #{remaining_capacity}
Items: #{items.map(&:number)}
  }
  end

  def <=>(other)
    value <=> other.value
  end
end
