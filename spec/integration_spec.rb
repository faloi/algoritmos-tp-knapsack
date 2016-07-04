require 'spec_helper'

describe 'Integration spec' do
  let(:instances) { Knapsack::Instance.all }
  let(:solvers) { [Knapsack::Solvers::Greedy.new, Knapsack::Solvers::GreedyRandom.new] }

  context 'comparative' do
    let(:solutions) { instances.map {|i| [i, solvers.map {|s| s.solve_for i }] } }
    before { puts solutions }
    it { expect(1).to eq(1) }
  end
end
