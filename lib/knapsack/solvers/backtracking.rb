require_relative './base'

class Knapsack::Solvers::Backtracking < Knapsack::Solvers::Base
  def initialize(max_minutes_to_run)
    @max_minutes_to_run = max_minutes_to_run
  end

  def compute_solution_for(instance)
    @best_solution_gain = 0
    @best_solution_items = []

    begin
      Timeout::timeout(@max_minutes_to_run * 60) do
        compute_recursive(instance.items, [], instance.capacity, 0)
      end
    rescue Timeout::Error
      # ignored
    end

    @best_solution_items
  end

  def compute_recursive(remaining_items, chosen_items, remaining_capacity, gain)
    if remaining_items.empty? || remaining_capacity == 0
      if gain > @best_solution_gain
        @best_solution_gain = gain
        @best_solution_items = chosen_items
      end

      return
    end

    compute_recursive(remaining_items.drop(1), chosen_items, remaining_capacity, gain)

    first_item = remaining_items.first
    if first_item.weight <= remaining_capacity
      compute_recursive(remaining_items.drop(1), chosen_items + [first_item], remaining_capacity - first_item.weight, gain + first_item.gain)
    end
  end
end
