require 'spec_helper'

describe Knapsack::Solvers::BranchAndBound do
  let(:branch_and_bound) { Knapsack::Solvers::BranchAndBound.new(5) }

  describe '#compute_solution_for' do
    let(:instance) { Knapsack::Instance.from_code 16 }
    let(:solution) { branch_and_bound.compute_solution_for instance }
    before { puts "Value: #{solution.value}, Optimal: #{instance.optimal_value}" }
    it { expect(solution.value).to be <= instance.optimal_value }
  end

  describe 'data for graphics' do
    before { puts generate_data_for_graphics(branch_and_bound) }
    it { }
  end
end
