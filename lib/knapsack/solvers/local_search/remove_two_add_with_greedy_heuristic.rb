require_relative './base_heuristic'

class Knapsack::Solvers::LocalSearch::RemoveTwoAddWithGreedyHeuristic
  extend Knapsack::Solvers::LocalSearch::BaseHeuristic

  class << self
    def try_to_improve(grasp, instance, initial_items, remaining_capacity)
      remaining_items = (instance.items - initial_items).sort_by(&:rate).reverse
      grasp.log "Will try to improve #{initial_items.map &:number}."

      initial_items.combination(2) do |items_to_remove|
        capacity_to_fill = remaining_capacity + items_to_remove.sum(&:weight)
        next_index = 0
        items_to_add = []

        while capacity_to_fill > 0 && next_index < remaining_items.size
          next_item = remaining_items[next_index]

          if next_item.weight <= capacity_to_fill
            items_to_add << next_item
            capacity_to_fill -= next_item.weight
          end

          next_index += 1
        end

        if items_to_add.sum(&:gain) > items_to_remove.sum(&:gain)
          new_items = replace_items_in_solution initial_items, items_to_remove, items_to_add
          log grasp, items_to_remove, new_items, capacity_to_fill

          return try_to_improve grasp, instance, new_items, capacity_to_fill
        end
      end

      fill_remaining_capacity(initial_items, remaining_capacity, remaining_items)

      initial_items
    end

    def replace_items_in_solution(initial_items, items_to_remove, items_to_add)
      (initial_items - items_to_remove) + items_to_add
    end
  end
end
