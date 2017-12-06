# Enum

A Ruby gem providing an `Enum` class.

## Simple example

```ruby
class Fruit
  attr_reader :type
  def initialize
    @type = Enum.new [:apple, :banana, :melon]
  end

  def price
    case type.to_sym
    when :apple  then  '2 DKK'
    when :banana then  '3 DKK'
    when :melon  then '15 DKK'
    end
  end
end

a = Fruit.new
a.type.apple!
#=> :apple

a.type.apple?
#=> true

a.type.banana?
#=> false

a.price
#=> "2 DKK"
```

## Advanced example

```ruby
class Footwear
  attr_reader :type
  def initialize
    @type = Class.new(Enum) do
      def decide(text)
        self.sym = case text
                   when /sandal/i then :sandal
                   when /boot/i   then :boot
                   else :shoe
                   end
      end
    end.new [:shoe, :sandal, :boot]
  end

  def price
    case type.to_sym
    when :shoe then '100 EUR'
    else '50 EUR'
    end
  end

  def laces?
    type.shoe?
  end
end

f = Footwear.new
f.type.decide('Nice boots!')
#=> :boot

f.price
#=> "50 EUR"

f.laces?
#=> false
```
