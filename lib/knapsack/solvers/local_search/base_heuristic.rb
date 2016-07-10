module Knapsack::Solvers::LocalSearch::BaseHeuristic
  def log(grasp, removed_items, new_items, new_capacity)
    grasp.log "Replaced #{removed_items} with #{new_items}, improving gain by #{new_items.sum(&:gain) - removed_items.sum(&:gain)}.\nRemaining capacity: #{new_capacity}."
  end

  def fill_remaining_capacity(initial_items, remaining_capacity, remaining_items)
    while remaining_capacity > 0 && remaining_items.any?
      next_index = 0
      next_item = remaining_items[next_index]
      remaining_items.delete_at next_index

      if next_item.weight <= remaining_capacity
        initial_items << next_item
        remaining_capacity -= next_item.weight
      end
    end
  end
end
