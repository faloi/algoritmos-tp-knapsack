require_relative './base_heuristic'

class Knapsack::Solvers::LocalSearch::RemoveOneAddTwoHeuristic
  extend Knapsack::Solvers::LocalSearch::BaseHeuristic

  class << self
    def try_to_improve(grasp, instance, initial_items, remaining_capacity)
      remaining_items = instance.items - initial_items
      puts "Will try to improve instance of #{initial_items.size} items, remaining capacity is #{remaining_capacity}, gain is #{initial_items.sum &:gain}, distance to optimal is #{(instance.optimal_value - initial_items.sum(&:gain).to_f) / instance.optimal_value * 100}%.\n"

      remaining_items.combination(2) do |pair|
        index_to_remove = 0

        while index_to_remove < initial_items.length
          item_to_remove = initial_items[index_to_remove]

          if can_be_replaced(item_to_remove, pair, remaining_capacity) && should_be_replaced(item_to_remove, pair)
            new_items, capacity_delta = replace_items_in_solution initial_items, index_to_remove, pair
            log grasp, [item_to_remove], pair, remaining_capacity - capacity_delta

            return try_to_improve grasp, instance, new_items, remaining_capacity - capacity_delta
          else
            index_to_remove += 1
          end
        end
      end

      fill_remaining_capacity(initial_items, remaining_capacity, remaining_items)

      initial_items
    end

    def should_be_replaced(item_to_remove, pair)
      item_to_remove.gain < pair.sum(&:gain)
    end

    def can_be_replaced(item_to_remove, pair, remaining_capacity)
      item_to_remove.weight + remaining_capacity >= pair.sum(&:weight)
    end

    def replace_items_in_solution(initial_items, index_to_remove, pair)
      items = initial_items.clone
      deleted_item = items.delete_at index_to_remove
      [items + pair, pair.sum(&:weight) - deleted_item.weight]
    end
  end
end
