require_relative './base'

class Knapsack::Solvers::Greedy < Knapsack::Solvers::Base
  def compute_solution_for(instance)
    compute_for(instance).first
  end

  def compute_bounds_for(instance)
    greedy, (next_item, *), remaining_capacity = compute_for instance

    lower_bound = greedy.sum(&:gain)
    relaxed_problem_plus = remaining_capacity > 0 ? next_item.rate * remaining_capacity : 0

    [lower_bound, lower_bound + relaxed_problem_plus]
  end

  def compute_for(instance)
    remaining_capacity = instance.capacity
    sorted_by_rate = instance.items.sort_by(&:rate).reverse

    result = []
    next_index = 0
    while remaining_capacity >= 0 && next_index < sorted_by_rate.size
      next_item = sorted_by_rate[next_index]

      if next_item.weight <= remaining_capacity
        result << next_item
        remaining_capacity -= next_item.weight
        sorted_by_rate.delete_at next_index
      else
        next_index += 1
      end
    end

    [result, sorted_by_rate, remaining_capacity]
  end
end
