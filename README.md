# Enum

A Ruby gem providing an `Enum` class.

## Example

```ruby
class Footwear
  type = Enum.new [:shoe, :sandal, :boot], do
    def decide(text)
      case text
      when /sandal/i then :sandal
      when /boot/i   then :boot
      else :shoe
      end
    end
  end

  def congrats
    "Congratulations with your new #{type.to_s}s"
  end

  def price
    case type
    when :shoe    then '100 USD'
    when :sandsal then  '75 USD'
    when :boot    then  '50 USD'
    end
  end

  def laces?
    type.shoe? or type.boot?
  end
end
```
