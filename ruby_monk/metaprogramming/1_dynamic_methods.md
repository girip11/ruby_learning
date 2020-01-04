# Metaprogramming

> Metaprogramming is the act of writing code that operates on code rather than on data - [rubymonk.com](https://rubymonk.com/learning/books/2-metaprogramming-ruby/chapters/32-introduction-to-metaprogramming/lessons/75-being-meta)

* Similar to Java or C# reflection

Examples of metaprogramming in ruby

* Opening existing ruby classes and adding methods to it.
* Method invocation using the `send` method.

## Open to change

* Add, remove or redefine methods to an existing class

```ruby
sample_array = (1..10).to_a
puts sample_array.number_of_elements

class Array
  def number_of_elements
    self.length
  end
end

puts sample_array.number_of_elements
```

## `send` method

* Using `send` we can call any method on the object.

* `send` accepts either a `String` or a `Symbol`

```ruby
simple_array = (0..10).to_a

# We can pass either a symbol or a string
simple_array.send(:length)
simple_array.send("length")
```

* Arguments to the method follow the first argument(name of the method to invoke on the object) of the `send`

```ruby
"foo,bar".send(:split, ",")
```

* Using `send`, **private methods of an object can be called**

```ruby
class Spy

  private
    def secrets
      "Secrets gathered by the spy"
    end
end

spy = Spy.new

puts spy.send(:secrets)
```

## Missing methods

* When an undefined method is invoked(sent a message) on an object, `method_missing` hook is called on that object.

```ruby
class Duck
  def quack
    "Quack"
  end

  def method_missing(action, *args, &block)
    puts "Duck can't #{action}" + (args.empty? ? "" : " #{args.join(" ")}")
    nil
  end
end

duck = Duck.new
puts duck.quack
puts duck.bark
if ! duck.roar("loud")
  puts "Duck can't roar"
end
puts duck.moo(5) do |n|
  n.times { puts "moo" }
end
```

* `send` when along with `method_missing` can handle calls to undefined methods on that object in a graceful way.

## `define_method` and `define_singleton_method`

* `define_method` is a class level method - a method defined using this method will be available to all instances of that class.

```ruby
class SuperHero
  # this defines fight and invisible as instance methods
  %w[fight invisible].each do |action|
    define_method("#{action}") do |weapon|
      "Performing #{action} with #{weapon}"
    end
  end
end

puts SuperHero.instance_methods(false).sort

batman = SuperHero.new
puts batman.respond_to?(:fight)

superman = SuperHero.new
puts superman.respond_to?(:fight)
```

* `define_singleton_method` - instance level method that can be used to define methods exclusive to that instance (singleton methods)

```ruby
class SuperHero
  def initialize(actions)
    actions.each do |action|
      define_singleton_method("#{action}") do |weapon|
        "Performing #{action} with #{weapon}"
      end
    end
  end

end

puts SuperHero.instance_methods(false).sort

batman = SuperHero.new(%w[drive invisible])
batman.drive("Bat mobile")
batman.invisible("cloake")

thor = SuperHero.new(%w[fight fly])
thor.fight("hammer")
thor.fly("cloake")
```

* Using this technique, methods with prefix `find_by` (`find_by_email`) are defined in rails models.

---

## References

* [Being Meta](https://rubymonk.com/learning/books/2-metaprogramming-ruby/chapters/32-introduction-to-metaprogramming/lessons/75-being-meta)

* [Using `send`](https://rubymonk.com/learning/books/2-metaprogramming-ruby/chapters/25-dynamic-methods/lessons/65-send)

* [Using `method_missing`](https://rubymonk.com/learning/books/2-metaprogramming-ruby/chapters/25-dynamic-methods/lessons/66-method-missing)

* [Using `define_method`](https://rubymonk.com/learning/books/2-metaprogramming-ruby/chapters/25-dynamic-methods/lessons/72-define-method)
