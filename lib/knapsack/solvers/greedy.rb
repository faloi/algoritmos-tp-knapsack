class Knapsack::Solvers::Greedy
  def solve_for(instance)
    remaining_capacity = instance.capacity
    sorted_by_rate = instance.items.sort_by(&:rate).reverse

    Knapsack::Solution.new(self, instance, sorted_by_rate.take_while do |x|
      remaining_capacity -= x.weight
      remaining_capacity >= 0
    end)
  end

  def name
    'Greedy'
  end
end
