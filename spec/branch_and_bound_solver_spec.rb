require 'spec_helper'

describe Knapsack::Solvers::BranchAndBound do
  describe '#compute_solution_for' do
    let(:instance) { Knapsack::Instance.from_file '018_1e3' }
    let(:solution) { Knapsack::Solvers::BranchAndBound.new(1).compute_solution_for instance }
    before { puts "Value: #{solution}, Optimal: #{instance.optimal_value}" }
    it { expect(solution).to be <= instance.optimal_value }
  end
end
