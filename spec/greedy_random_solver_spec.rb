require 'spec_helper'

describe Knapsack::Solvers::GreedyRandom do
  describe '#solve_for' do
    let(:instance) { Knapsack::Instance.from_file '006_3e3' }

    context 'works' do
      let(:solution) { Knapsack::Solvers::GreedyRandom.new.solve_for instance }
      before { puts solution }
      it { expect(solution.value).to be <= instance.optimal_value }
    end
  end
end
