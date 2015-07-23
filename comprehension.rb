class Comprehension
  attr_reader :rawlist, :bindings, :where, :list
  def initialize(rawlist, bindings, where: nil)
    @rawlist = rawlist
    @bindings = bindings
    @where = where
  end

  def list
    enumerator.each_with_object([]) do |el, obj|
      obj << el
    end
  end

  def each(&block)
    enumerator.each { |el| block.call(el) }
  end

  def enumerator
    Enumerator.new do |y|
      combine_hash(bindings) do |keys|
        y << parse(keys)
      end
    end
  end

  private

  def combine_hash(hash)
    if hash.empty?
      yield hash
    else
      dup = hash.dup
      key, list = dup.shift
      list.each do |el|
        combine_hash(dup) { |arg| yield({key => el}.merge(arg)) }
      end
    end
  end

  def parse(keys)
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
end
