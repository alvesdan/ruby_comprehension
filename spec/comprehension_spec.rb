require './comprehension'
require 'rspec'
require 'pry'

RSpec.describe Comprehension do

  it 'understands simple arrays' do
    c = described_class.new([:i, :j], i: [1, 2], j: [1, 2, 3, 4])
    expect(c.result.take(10)).to eq ([[1, 1], [1, 2], [1, 3], [1, 4], [2, 1], [2, 2], [2, 3], [2, 4]])
  end

  it 'understands procs' do
    c = described_class.new(proc { |i, j| i * j }, i: [1, 2], j: [3, 4])
    expect(c.result).to eq ([3, 4, 6, 8])
  end

  it 'understands three arrays' do
    c = described_class.new([:i, :j, proc { |i, j, k| (i * j) - k }], i: [1, 2], j: [1, 2, 3, 4], k: [5, 6])
    expect(c.result).to include([1, 2, -3], [1, 2, -4], [1, 3, -2])
  end
end
