# `instance_eval`

* `instance_eval` - context is the object(**self**) on which it is invoked.
* Method signature `instance_eval(ruby_code, file_num, line_num)`
* `instance_eval` can also accept a block.

## Adding class level methods

* If the `instance_eval` is invoked on a **class** (user defined classes are instances of `Class`) to add some methods, then the methods are added to that class instance, which makes them as class level methods.

```ruby

simple_method = <<-'EOF'
def simple_method(msg)
  puts "#{msg}"
end
EOF

class SimpleClass
end

SimpleClass.respond_to?(:instance_eval)
SimpleClass.method(:instance_eval).owner

SimpleClass.instance_eval(simple_method)

# method added as singleton method to the singleton class of SimpleClass
SimpleClass.singleton_methods(false)

SimpleClass.simple_method("Hello World")
```

## Defining singleton methods

```ruby
simple_method = <<-'EOF'
def simple_method(msg)
  puts "#{msg}"
end
EOF

class SimpleClass
end

sc = SimpleClass.new

# simple_method will be available only on this instance
sc.instance_eval(simple_method)
sc.simple_method("Hello World")

# raises error
SimpleClass.new.simple_method("Hello World")
```

* Use the `instance_eval` method on instances of class. Prefer `class_eval` for executing code in the context of the class.

---

## References

* [Eval on instances](https://www.rubymonk.com/learning/books/5-metaprogramming-ruby-ascent/chapters/24-eval/lessons/67-instance-eval)
