class Comprehension
  attr_reader :rawlist, :bindings, :where, :list
  def initialize(rawlist, bindings, where: nil)
    @rawlist = rawlist
    @bindings = bindings
    @where = where
    @list = []
    comprehend
  end

  private

  def comprehend(keys = {}, offset: 0)
    if bindings.any?
      key, values = array_bindings[offset]
      values.map do |value|
        comprehend(keys.merge(key => value), offset: offset + 1)
      end if values
    end

    if keys.size == rawlist.size
      @list << rawlist.map { |k| keys[k] }
    end
  end

  def array_bindings
    bindings.map { |k,v| [k,v] }
  end
end
