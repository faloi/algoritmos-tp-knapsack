require 'spec_helper'

describe Knapsack::Instance do
  describe '#from_file' do
    let(:instance) { Knapsack::Instance.from_file '000_3e1' }

    context 'parses the capacity' do
      it { expect(instance.capacity).to eq 162 }
    end

    context 'parses the items' do
      it { expect(instance.items.size).to eq 30 }
      it { expect(instance.items.last).to eq Knapsack::Item.new(21, 7) }
    end
  end
end
