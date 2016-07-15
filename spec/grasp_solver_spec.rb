require 'spec_helper'

describe Knapsack::Solvers::Grasp do
  describe '#solve_for' do
    let(:instance) { Knapsack::Instance.from_code 22 }
    let(:with_greedy_local_search) { Knapsack::Solvers::Grasp.new 1, 2, 5, Knapsack::Solvers::LocalSearch::RemoveTwoAddWithGreedyHeuristic }
    let(:remove_one_add_two_local_search) { Knapsack::Solvers::Grasp.new 3, 2, 5, Knapsack::Solvers::LocalSearch::RemoveOneAddTwoHeuristic }

    context 'remove one add two' do
      let(:solution) { remove_one_add_two_local_search.solve_for instance }
      before { puts solution }
      it { expect(solution.value).to be <= instance.optimal_value }
    end

    context 'remove two add using greedy' do
      let(:solution) { with_greedy_local_search.solve_for instance }
      before { puts solution }
      it { expect(solution.value).to be <= instance.optimal_value }
    end

    describe 'data for graphics' do
      before { puts generate_data_for_graphics(remove_one_add_two_local_search) }
      it { }
    end
  end
end
