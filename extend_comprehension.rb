require './comprehension'

module ExtendComprehension
  def c(rawlist, bindings)
    Comprehension.new(rawlist, bindings).list
  end
end
extend ExtendComprehension
