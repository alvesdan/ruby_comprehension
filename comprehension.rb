class Comprehension
  attr_reader :rawlist, :bindings, :where, :list
  def initialize(rawlist, bindings, where: nil)
    @rawlist = rawlist
    @bindings = bindings
    @where = where
    @list = []
    comprehend
  end

  def result
    Enumerator.new do |value|
      row = @list[value]
      break unless row
      yielder << element(row) if row
     end
  end

  private

  def comprehend(keys = {}, offset: 0)
    if bindings.any?
      key, values = array_bindings[offset]
      Array(values).each do |value|
        comprehend(keys.merge(key => value), offset: offset + 1)
      end if values
    end

    @list << keys if keys.size == bindings.size
  end

  def element(keys)
    case rawlist
    when Symbol
      keys[rawlist]
    when Proc
      rawlist.call(*keys.values)
    when Array
      rawlist.map do |k|
        if k.is_a?(Proc)
          k.call(*keys.values)
        else
          keys[k]
        end
      end
    end
  end

  def array_bindings
    bindings.map { |k,v| [k,v] }
  end
end
