require_relative './base'

class Knapsack::Solvers::Greedy < Knapsack::Solvers::Base
  def compute_solution_for(instance)
    remaining_capacity = instance.capacity
    sorted_by_rate = instance.items.sort_by(&:rate).reverse

    sorted_by_rate.take_while do |x|
      remaining_capacity -= x.weight
      remaining_capacity >= 0
    end
  end
end
