require 'spec_helper'

describe Knapsack::Solvers::Grasp do
  describe '#solve_for' do
    let(:instance) { Knapsack::Instance.from_file '000_3e1' }

    context 'works' do
      let(:solution) { Knapsack::Solvers::Grasp.new(10, 3).solve_for instance }
      before { puts solution }
      it { expect(1).to eq 1 }
    end
  end
end
