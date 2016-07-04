require_relative './base'

class Knapsack::Solvers::GreedyRandom < Knapsack::Solvers::Base
  def compute_solution_for(instance)
    remaining_capacity = instance.capacity
    remaining_items = instance.items
    chosen_items = []

    while remaining_capacity > 0 && remaining_items.any?
      rates_sum = remaining_items.sum &:rate
      weights_hash = Hash[remaining_items.map do |x|
                            [x, x.rate / rates_sum]
                          end]

      next_index = get_random_index weights_hash
      next_item = weights_hash.keys[next_index]

      remaining_items.delete next_item

      if next_item.weight <= remaining_capacity
        chosen_items << next_item
        remaining_capacity -= next_item.weight
      end
    end

    chosen_items
  end

  private

  def get_random_index(weights_hash)
    weights = weights_hash.values
    number = rand
    i = 0

    while number > weights[i]
      number -= weights[i]
      i += 1
    end

    i
  end
end
