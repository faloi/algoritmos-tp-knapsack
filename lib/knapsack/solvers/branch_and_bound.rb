require_relative './base'

class Knapsack::Solvers::BranchAndBound < Knapsack::Solvers::Base
  def compute_solution_for(instance)
    to_visit = [TreeNode.new(instance.items.sort_by(&:rate).reverse, instance.capacity, 0)]
    lower_bound = 0

    while to_visit.any?
      current_node = to_visit.shift

      next unless current_node.has_many_items?
      next if current_node.capacity < 0
      next if current_node.upper < lower_bound

      if current_node.lower > lower_bound
        lower_bound = current_node.lower
      end

      if current_node.lower != current_node.upper
        to_visit += current_node.next_level
      end
    end

    lower_bound
  end
end

class TreeNode
  attr_reader :lower, :upper, :capacity

  def initialize(items, capacity, gain)
    @lower, @upper = bounds_for(items, capacity).map {|x| x + gain}

    @items = items
    @capacity = capacity
    @gain = gain
  end

  def next_level
    next_item, remaining = split_items
    [TreeNode.new(remaining, @capacity, @gain), TreeNode.new(remaining, @capacity - next_item.weight, @gain + next_item.gain)]
  end

  def split_items
    [@items.first, @items.drop(1)]
  end

  def has_many_items?
    @items.size > 1
  end

  def bounds_for(items, capacity)
    Knapsack::Solvers::Greedy.new.compute_bounds_for Knapsack::Instance.new('B&B', items, capacity, 0)
  end
end
