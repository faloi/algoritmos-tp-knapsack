require 'spec_helper'

describe Knapsack::Solvers::Grasp do
  describe '#solve_for' do
    let(:instance) { Knapsack::Instance.from_code 23 }

    context 'remove one add two' do
      let(:solution) { Knapsack::Solvers::Grasp.new(1, 3, 5, Knapsack::Solvers::LocalSearch::RemoveOneAddTwoHeuristic).solve_for instance }
      before { puts solution }
      it { expect(solution.value).to be <= instance.optimal_value }
    end

    context 'remove two add using greedy' do
      let(:solution) { Knapsack::Solvers::Grasp.new(1, 2, 5, Knapsack::Solvers::LocalSearch::RemoveTwoAddWithGreedyHeuristic).solve_for instance }
      before { puts solution }
      it { expect(solution.value).to be <= instance.optimal_value }
    end
  end
end
