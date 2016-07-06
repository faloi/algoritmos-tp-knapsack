module Knapsack::Solvers::LocalSearch::RemoveOneAddTwoHeuristic
  class << self
    def try_to_improve(instance, greedy_solution)
      remaining_items = instance.items - greedy_solution.items

      remaining_items.combination(2) do |pair|
        index_to_remove = 0

        while index_to_remove < greedy_solution.items.length
          item_to_remove = greedy_solution.items[index_to_remove]

          if can_be_replaced(item_to_remove, pair, greedy_solution.remaining_capacity) && should_be_replaced(item_to_remove, pair)
            return replace_items_in_solution greedy_solution, index_to_remove, pair
          else
            index_to_remove += 1
          end
        end
      end

      greedy_solution.items
    end

    def should_be_replaced(item_to_remove, pair)
      item_to_remove.gain < pair.sum(&:gain)
    end

    def can_be_replaced(item_to_remove, pair, remaining_capacity)
      item_to_remove.weight + remaining_capacity >= pair.sum(&:weight)
    end

    def replace_items_in_solution(best_solution, index_to_remove, pair)
      items = best_solution.items.clone
      items.delete_at index_to_remove
      items + pair
    end
  end
end
