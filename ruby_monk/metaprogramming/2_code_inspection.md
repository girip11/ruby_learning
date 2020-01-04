# Code inspection

## `method`

* `method` returns `Method` object using which we can inspect about the method.

```ruby
class SimpleClass
  def simple_method(arg)
    "Simple method with argument #{arg}"
  end
end

simple_object = SimpleClass.new
method_object = simple_object.method(:simple_method)
puts method_object

puts method_object.name

# invoking the method
puts method_object.call("hello")

# The parameter method returns all the parameters that the method is defined
#with. It returns an array of key-value pairs. The key is a symbol representing
# the type of the parameter -- :req for a mandatory parameter, :rest, for the
# variable arguments, :opt for the default optional parameters and :block for
# the block parameters. The value is the symbolized form of the parameter itself.
puts method_object.parameters

# The arity method in the above example returns a Fixnum
# representing the number of arguments that the method can accept
puts method_object.arity

# Instance from which this method was extracted
puts method_object.receiver

# Class/Module from which instances get this method
puts method_object.owner
```

## Listing all methods

* `public_methods` - returns all the instance methods and the class methods belonging to that object and the ones accessible on that object's ancestors

* `public_methods(false)` - Does not include any method(instance and class methods) from ancestors

* `private_methods`, `protected_methods`, `singleton_methods`

## `const_get`

* `const_get` is defined in Module. It is available to `Class` instances as well.

* Works with `String` as well as `Symbol`.

* Can fetch **constants only**(Class and module names are constants and identifiers with all capital letters are treated as constants in Ruby)

```Ruby
RETRY_COUNT = 3
puts Module.const_get("RETRY_COUNT")

class SimpleClass
  TIMEOUT = 3000

  def simple_method
    "Simple method invoked"
  end
end

# Returns class itself
puts Module.const_get("SimpleClass").instance_methods(false)

puts SimpleClass.const_get("TIMEOUT")
```

* Names that are not constants won't be returned by `const_get`

```ruby
my_class = Class.new

my_class.class_eval do
  def simple_instance_method
    puts "Instance method"
  end
end

# raises NameError
puts Module.const_get("my_class")
```

* In rails controller instantiation based on the URL, happens with the help of this `const_get`.

* If the constant is not found in the class, then the constant will be searched in the class's ancestor chain.

## `instance_variable_get`

* `puts self.method(:instance_variable_get).owner` - prints `Kernel`

* Used to fetch the value of the instance variable of the object

```ruby
class Student

  def initialize(name, age)
    @name = name
    @age = age
  end
end

st = Student.new('John', 16)

# @ is not optional
puts st.instance_variable_get("@name")
puts st.instance_variable_get(:@name)

puts Module.const_get("Student").new("Jane", 18).instance_variable_get("@name")
```

* This method should be used only for metaprogramming and inspection purposes during development.
* In normal cases, instance variables should be accessed through `attr_accessor` or `attr_reader`

---

## References

* [Inspector Gadget](https://rubymonk.com/learning/books/2-metaprogramming-ruby/chapters/46-code-inspection/lessons/106-inspector-gadget)
* [Tap in deeper](https://rubymonk.com/learning/books/2-metaprogramming-ruby/chapters/46-code-inspection/lessons/107-tap-in-deeper)
