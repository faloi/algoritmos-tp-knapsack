require_relative './base'

class Knapsack::Solvers::Grasp < Knapsack::Solvers::Base
  def initialize(max_iterations, max_without_improving, max_minutes_to_run, local_search_heuristic)
    @max_iterations = max_iterations
    @max_without_improving = max_without_improving
    @max_minutes_to_run = max_minutes_to_run
    @local_search_heuristic = local_search_heuristic
    @logs = []
  end

  def info(instance)
    "Iterated #{@iterations} times.\n#{@logs.join "\n"}\n\nFinal solution:"
  end

  def compute_solution_for(instance)
    @iterations = 0
    without_improving = 0
    best_solution = Knapsack::Solution.empty self, instance

    begin
      Timeout::timeout(@max_minutes_to_run * 60) do
        while @iterations <= @max_iterations && without_improving < @max_without_improving
          @iterations += 1
          new_solution = solve_iteration_for instance

          if new_solution > best_solution
            log "Solution improved! New gain is #{new_solution.value}."
            best_solution = new_solution
          else
            without_improving += 1
          end
        end
      end
    rescue Timeout::Error
      # ignored
    end

    best_solution.items
  end

  def solve_iteration_for(instance)
    greedy_solution = Knapsack::Solvers::GreedyRandom.new.solve_for instance
    log "------------------\nStarted iteration ##{@iterations} - greedy solution value is #{greedy_solution.value}, with remaining capacity #{greedy_solution.remaining_capacity}."

    best_combination = @local_search_heuristic.try_to_improve self, instance, greedy_solution.items, greedy_solution.remaining_capacity

    Knapsack::Solution.new self, instance, best_combination
  end

  def log(event)
    @logs << event
  end
end
