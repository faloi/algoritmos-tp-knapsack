require_relative './base'

class Knapsack::Solvers::Grasp < Knapsack::Solvers::Base
  def initialize(max_iterations, max_without_improving, local_search_heuristic)
    @max_iterations = max_iterations
    @max_without_improving = max_without_improving
    @local_search_heuristic = local_search_heuristic
    @logs = []
  end

  def info(instance)
    "Iterated #{@iterations} times.\n#{@logs.join "\n"}\n"
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
    log "\n------------------\nStarted iteration ##{@iterations}, with greedy solution #{greedy_solution}"

    best_combination = @local_search_heuristic.try_to_improve self, instance, greedy_solution.items, greedy_solution.remaining_capacity

    Knapsack::Solution.new self, instance, best_combination
  end

  def log(event)
    @logs << event
  end
end
