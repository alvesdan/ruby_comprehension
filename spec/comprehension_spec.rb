require './comprehension'
require 'rspec'
require 'pry'

RSpec.describe Comprehension do

  it 'understands comprehension' do
    c = described_class.new([:i, :j], i: [1, 2], j: [1, 2, 3, 4])
    expect(c.list).to eq ([[1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4]])
  end

  it 'understands comprehension' do
    c = described_class.new([:i, :j], i: [1, 2], j: [3, 4])
    expect(c.list).to eq ([[1,3],[1,4],[2,3],[2,4]])
  end

  it 'understands comprehension' do
    c = described_class.new([:i, :j, :k], i: [1, 2], j: [1, 2, 3, 4], k: [5, 6])
    expect(c.list).to include([1,1,5])
    expect(c.list).to eq([[1, 1, 5], [1, 1, 6], [1, 2, 5], [1, 2, 6], [1, 3, 5], [1, 3, 6], [1, 4, 5], [1, 4, 6], [2, 1, 5], [2, 1, 6], [2, 2, 5], [2, 2, 6], [2, 3, 5], [2, 3, 6], [2, 4, 5], [2, 4, 6]])
  end
end