# `eval`

* Code as data
* `eval` - method provided by the `Kernel` module

```ruby
ruby_exp = "10 * 5"
puts eval(ruby_exp)
```

* Any ruby code can be given as input to `eval`.

```ruby
# EOF single quoted to take the content literally
say_hello_method = <<-'EOF'
def say_hello(name)
  puts "Hello #{name}"
end
EOF

eval(say_hello_method)
say_hello "John"
```

## cons of using `eval`

* Risk of executing malicious code
* Less maintainability
* Reduces the effectiveness of static code analysis tools

> `eval` should best be avoided in real scenarios. Ruby has saner tools (#define_method, #send) in its meta-programming repertoire that you can use to achieve eval-like cleverness.

## Bindings

* `Binding` - object that stores the context of the scope and state but no code.
* With binding, we can provide the context to `eval` so that the code is evaluated in that context of the program.
* `Kernel` module provides a method called `binding`

> Ruby provides with a constant `TOPLEVEL_BINDING`, which is a Binding object that always represents the top-level scope of your program.

`TOPLEVEL_BINDING.class` - returns `Binding`

```ruby
def main_object_method_binding
  binding
end

# binding is a private method provided by Kernel module
class SimpleClass
  def self.get_class_level_binding
    # returns the class level binding
    binding
  end

  def get_instance_level_binding
    # returns the instance level binding
    binding
  end
end

simple_method = <<-'EOF'
def simple_method(msg)
  puts "#{msg}"
end
EOF

puts(eval("self.class", main_object_method_binding))
puts(eval("self.class", SimpleClass.new.get_instance_level_binding))

# before eval
SimpleClass.instance_methods(false).sort

# binding context is that of the class
# this adds the instance method to the class
# NOTE this does not add the simple_method as class level method
eval(simple_method, SimpleClass.get_class_level_binding)

# after eval
SimpleClass.instance_methods(false).sort
```

* `__FILE__` (__FILE__ returns a string of the name of the file currently being executed) and `__LINE__` can also be passed to `eval`.

---

## References

* [Eval](https://www.rubymonk.com/learning/books/5-metaprogramming-ruby-ascent/chapters/24-eval/lessons/63-eval)
