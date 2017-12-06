class Enum
  class Error < StandardError; end

  attr_reader :symbols

  def initialize(symbols)
    raise Enum::Error, 'All symbols must be symbols' unless symbols.all?{|v| v.is_a?(Symbol)}
    raise Enum::Error, 'Values must be unique' unless symbols.uniq == symbols

    @symbols = symbols.freeze

    symbols.each do |symbol|
      setter = "#{symbol.to_s}!".to_sym
      getter = "#{symbol.to_s}?".to_sym

      err_if_conflict(symbol, setter)
      err_if_conflict(symbol, getter)

      eigenclass = class << self; self; end
      eigenclass.send(:define_method, setter) { @symbol = symbol }
      eigenclass.send(:define_method, getter) { @symbol == symbol }
    end
  end

  def sym=(other)
    raise Enum::Error, "Unknown symbol '#{other}'" if !other.nil? && !symbols.include?(other)

    @symbol = other
  end

  def to_sym
    @symbol
  end

  private

  def err_if_conflict(symbol, method_sym)
    if self.respond_to?(method_sym)
      raise ArgumentError,
        "You tried to define an enum but the symbol \"#{symbol}\" cannot be used " \
        "because the method name \"#{method_sym.to_s}\" is already used."
    end
  end
end
