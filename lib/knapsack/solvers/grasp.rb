require_relative './base'

class Knapsack::Solvers::Grasp < Knapsack::Solvers::Base
  def initialize(max_iterations, max_without_improving)
    @max_iterations = max_iterations
    @max_without_improving = max_without_improving
    @logs = []
  end

  def info(instance)
    separator = "-------------------\n"
    "Iterated #{@iterations} times.\n#{separator}" + @logs.join(separator) + "\n#{separator}"
  end

  def compute_solution_for(instance)
    @iterations = 1
    without_improving = 0
    best_solution = solve_iteration_for instance

    while @iterations < @max_iterations && without_improving < @max_without_improving
      @iterations += 1
      new_solution = solve_iteration_for instance

      if new_solution > best_solution
        best_solution = new_solution
      else
        without_improving += 1
      end
    end

    best_solution.items
  end

  def solve_iteration_for(instance)
    greedy_solution = Knapsack::Solvers::GreedyRandom.new.solve_for instance
    log "Started iteration ##{@iterations}, with greedy solution #{greedy_solution}"

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

    greedy_solution
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
    items += pair

    Knapsack::Solution.new(self, best_solution.instance, items)
  end

  def log(event)
    @logs << event
  end
end
