class Comprehension
  attr_reader :rawlist, :bindings, :where
  def initialize(rawlist, bindings, where: nil)
    @rawlist = rawlist
    @bindings = bindings
    @where = where
    @result = []
  end

  def list
    while bindings_available?
      values.each do |key, val|
        merge(key, val, values)
      end
    end
    @result
  end

  private

  def bindings_number
    bindings.keys.size
  end

  def bindings_available?
    puts "BINDINGS: #{bindings.inspect}"
    bindings.any? { |k, v| v.size > 1 }
  end

  def values
    ({}).tap do |values|
      bindings.each do |key, val|
        values[key] = val.size > 1 ? val.shift : val
      end
    end
  end

  def merge(key, val, values)
    puts "FILTERED: #{filtered(key)}"
    filtered(key).each do |i, list|
      list.each do |v|
        @result << rawlist.map { |r|
          case r
          when key then val
          when i then v
          else
            values[r]
          end
        }
      end
    end
  end

  def filtered(key)
    bindings.reject { |k, v| k == key }
  end

end
