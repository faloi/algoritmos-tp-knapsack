require 'benchmark'
require_relative '../lib/knapsack'

def compute_and_report_time(solver, instance)
  value = nil
  time = Benchmark.realtime { value = solver.solve_for(instance).value }
  [value, time]
end

def generate_data_for_graphics(solver)
  instances = (12..23).map { |x| Knapsack::Instance.from_code x }
  solutions = instances.map { |i| [i.name, i.items.size, i.capacity, i.optimal_value] + compute_and_report_time(solver, i) }

  solver.name + "\n" + solutions.map { |s| s.join(',') }.join("\n")
end
