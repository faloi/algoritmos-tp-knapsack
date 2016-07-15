require_relative './base'

class Knapsack::Solvers::BranchAndBound < Knapsack::Solvers::Base
  def initialize(max_minutes_to_run)
    @max_minutes_to_run = max_minutes_to_run
    @visited_nodes = 0
  end

  def compute_solution_for(instance)
    to_visit = [TreeNode.new(sort_items_by_best_rate(instance), instance.capacity, 0)]
    lower_bound = 0

    begin
      Timeout::timeout(@max_minutes_to_run * 60) do
        while to_visit.any?
          current_node = to_visit.shift
          @visited_nodes += 1

          next unless current_node.has_many_items?
          next if current_node.capacity < 0
          next if current_node.upper < lower_bound

          if current_node.lower > lower_bound
            lower_bound = current_node.lower
            puts "Maximum reached! Node: #{@visited_nodes}, value: #{lower_bound}."
          end

          if current_node.lower != current_node.upper
            to_visit += current_node.next_level
          end
        end
      end
    rescue Timeout::Error
      # ignored
    end

    puts "Visited #{@visited_nodes} nodes."

    lower_bound
  end

  def sort_items_by_best_rate(instance)
    instance.items.sort_by(&:rate).reverse
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
