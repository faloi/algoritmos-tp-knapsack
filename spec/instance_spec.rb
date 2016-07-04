require 'spec_helper'

describe Knapsack::Instance do
  describe '#from_file' do
    let(:instance) { Knapsack::Instance.from_file '002_3e1' }

    context 'parses the capacity' do
      it { expect(instance.capacity).to eq 2190 }
    end

    context 'parses the items' do
      it { expect(instance.items.size).to eq 30 }
      it { expect(instance.items.last).to eq Knapsack::Item.new(29, 264, 240) }
    end

    context 'parses the optimal value' do
      it { expect(instance.optimal_value).to eq 2790 }
    end
  end
end
