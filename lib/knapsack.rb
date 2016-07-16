module Knapsack
end

require 'timeout'

require_relative './knapsack/array'
require_relative './knapsack/instance'
require_relative './knapsack/item'
require_relative './knapsack/solution'
require_relative './knapsack/solvers'

# To execute this file, open a terminal on the root of this project and run "ruby lib/knapsack.rb".

instance = Knapsack::Instance.from_code 13 # this is the code of the instance
solver = Knapsack::Solvers::Backtracking.new(2) # for examples of other solvers, see the specs

puts solver.solve_for(instance)
