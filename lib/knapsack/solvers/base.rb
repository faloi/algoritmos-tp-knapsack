class Knapsack::Solvers::Base
  def name
    self.class.name.split('::').last.gsub(/[A-Z]/, ' \0').strip
  end

  def info(instance)
    ''
  end

  def solve_for(instance)
    Knapsack::Solution.new self, instance, compute_solution_for(instance)
  end
end
