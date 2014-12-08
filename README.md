Just a weekend pastime implementation for fun.

```ruby
require './extend_comprehension'

c [:a, :b], a: [1, 2], b: [3, 4]
#=> [[1, 3], [1, 4], [2, 3], [2, 4]]

c [:i, :j, proc { |i, j| i * j }], i: [1, 2, 3, 4], j: [5, 6]
#=> [[1, 5, 5], [1, 6, 6], [2, 5, 10], [2, 6, 12], [3, 5, 15], [3, 6, 18], [4, 5, 20], [4, 6, 24]]

c proc { |a, b| a * b }, a: [5, 10, 20], b: [2, 4, 6]
#=> [10, 20, 30, 20, 40, 60, 40, 80, 120]
```
