# `class_eval`

* `class_eval` - available only on classes and modules. This method comes from `Module`

* Any code evaluated using `class_eval` is equivalent to opening the class and adding the code to the class.

```ruby
class SimpleClass
end

SimpleClass.class_eval do
  # class_variable_set(:@@count, 0)

  def self.count
    @@count ||= 0
  end

  def initialize(msg)
    @msg = msg
    @@count += 1
  end

  def print_message
    puts "#{@msg}"
  end
end

SimpleClass.new("Message1")
SimpleClass.new("Message2").print_message
SimpleClass.new("Message3")

puts SimpleClass.count
```

---

## References

* [Eval on classes](https://www.rubymonk.com/learning/books/5-metaprogramming-ruby-ascent/chapters/24-eval/lessons/68-class-eval)
