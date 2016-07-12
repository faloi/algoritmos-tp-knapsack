require 'spec_helper'

describe Knapsack::Solvers::Greedy do
  let(:instance) { Knapsack::Instance.from_file '000_3e1' }
  let(:greedy) { Knapsack::Solvers::Greedy.new }

  describe '#solve_for' do
    let(:solution) { greedy.solve_for instance }
    before { puts solution }
    it { expect(solution.value).to be <= instance.optimal_value }
  end

  describe '#compute_bounds_for'do
    let(:bounds) { greedy.compute_bounds_for instance }
    before { puts bounds.to_s }
    it { expect(bounds.first).to be <= instance.optimal_value }
    it { expect(bounds.last).to be >= instance.optimal_value }
  end
end
