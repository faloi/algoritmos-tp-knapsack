require_relative './base'

class Knapsack::Solvers::GreedyRandom < Knapsack::Solvers::Base
  def compute_solution_for(instance)
    remaining_capacity = instance.capacity
    remaining_items = instance.items.sort { |x, y| y.rate - x.rate }
    chosen_items = []

    while remaining_capacity > 0 && remaining_items.any?
      next_index = pick_random_index remaining_items
      next_item = remaining_items[next_index]
      remaining_items.delete_at next_index

      if next_item.weight <= remaining_capacity
        chosen_items << next_item
        remaining_capacity -= next_item.weight
      end
    end

    chosen_items
  end

  private

  def pick_random_index(items)
    rand [items.length, items.length * 0.1].min
  end
end
