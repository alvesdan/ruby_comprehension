require './comprehension'
require 'rspec/autorun'

RSpec.describe Comprehension do

  it 'understands comprehension' do
    c = described_class.new([:i, :j], i: [1, 2], j: [1, 2, 3, 4])
    expect(c.list).to eq ([[1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4]])
  end

  it 'understands comprehension' do
    c = described_class.new([:i, :j, :k], i: [1, 2], j: [1, 2, 3, 4], k: [1, 2, 3, 4, 5, 6])
    expect(c.list).to include([1,1,5])
  end
end
