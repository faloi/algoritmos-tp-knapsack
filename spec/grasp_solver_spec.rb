require 'spec_helper'

describe Knapsack::Solvers::Grasp do
  describe '#solve_for' do
    let(:instance) { Knapsack::Instance.from_file '020_1e3' }

    context 'remove one add two' do
      let(:solution) { Knapsack::Solvers::Grasp.new(10, 3, Knapsack::Solvers::LocalSearch::RemoveOneAddTwoHeuristic).solve_for instance }
      before { puts solution }
      it { expect(solution.value).to be <= instance.optimal_value }
    end

    context 'remove two add using greedy' do
      let(:solution) { Knapsack::Solvers::Grasp.new(20, 2, Knapsack::Solvers::LocalSearch::RemoveTwoAddWithGreedyHeuristic).solve_for instance }
      before { puts solution }
      it { expect(solution.value).to be <= instance.optimal_value }
    end
  end
end
