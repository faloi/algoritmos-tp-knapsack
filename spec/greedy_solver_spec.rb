require 'spec_helper'

describe Knapsack::Solvers::Greedy do
  describe '#solve_for' do
    let(:instance) { Knapsack::Instance.from_file '000_3e1' }

    context 'works' do
      let(:solution) { Knapsack::Solvers::Greedy.new.solve_for instance }
      before { puts solution }
      it { expect(solution.value).to eq 348 }
    end
  end
end
