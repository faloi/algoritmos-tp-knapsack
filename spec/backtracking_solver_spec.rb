require 'spec_helper'

describe Knapsack::Solvers::Backtracking do
  let(:instance) { Knapsack::Instance.from_code 13 }
  let(:backtracking) { Knapsack::Solvers::Backtracking.new(2) }

  describe '#solve_for' do
    let(:solution) { backtracking.solve_for instance }
    before { puts solution }
    it { expect(solution.value).to be <= instance.optimal_value }
  end

  describe 'data for graphics' do
    before { puts generate_data_for_graphics(backtracking) }
    it { }
  end
end
