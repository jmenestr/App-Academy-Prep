# Object

## Goals
- Know what an object is.
- Know that everything in Ruby is an object.
- Know that every class in Ruby is a subclass of `Object`.
- Know how to get more information about an object.

## What is an object?

Think of an object as a convenient package for relevant information and
behavior. Objects can store state (in the form of variables) and respond
to messages (which are typically dispatched through method calls). For
example, an `Array` is an object that stores information (an ordered
sequence of objects) and provides methods (such as `sort` and `slice`)
that allow us to interact with that information.

## We are all `Object`s now

In Ruby, everything is an Object. This means that hashes, strings,
objects from user-defined classes, and even numbers all have methods.
This is different from some other languages like Java or C++ where ints,
floats, and strings are special, non-object *primitive* types.

The fact that everything is an object is part of what makes Ruby so
expressive (though there are performance trade-offs). For instance, we
get lots of powerful methods on the basic types:

```ruby
"to low a case".upcase # => "TO LOW A CASE"
3.times { puts "Three times round!" } # prints this three times
(3.3).round # => 3
```

Every class -- whether it's Hash, Array, String, or Int -- inherits
from a single, root class Object. Everything really is an Object.

The methods of the Object class are available on every object, no matter
the class. There are a few very useful methods.

## `inspect` and `to_s`

Every class inherits two methods: `inspect` and `to_s`.

`to_s` converts the value to a string. For instance:

```ruby
3.to_s # => "3"
[1, 2, 3].to_s # => "[1, 2, 3]"
"my_string".to_s # => "my_string" (already a string)
nil.to_s # => "" (nil represented as nothing, or emptiness)
```

`inspect` returns a debugging string that represents the Ruby object.
`inspect` is meant to be used, for instance, in the interpreter, or to
print out debugging information:

```ruby
3.inspect # => "3" (same as to_s)
[1, 2, 3].inspect # => "[1, 2, 3]" (same as to_s)
"my_string".inspect # => '"my_string"' (notice the quotes)
nil.inspect # => "nil"
```

### `puts` vs `p`

When printing to output using the methods `puts` and `p`, they call
`to_s` and `inspect` on their argument for you. For instance:

```ruby
puts "my string!" # prints "my string!"
p "my string!" # prints '"my string!"'
```

In particular:

```ruby
puts nil # => prints a blank line
p nil # => prints "nil"
```

`puts` is the method to use when we're printing output that the user
(a non-programmer) wants to read. `p` is the method to use when
printing out debugging information that a programmer wants to read.

### The `Kernel` module

Methods that are defined at the top level scope are methods of the
`Kernel` module. The `Kernel` module is mixed into every class, so
that you may call these "global" methods from any context. If you are
looking for the definition of global methods like `puts` and `gets`,
you'll want to look at the `Kernel` documentation.

Don't worry if this doesn't make sense at this moment; you can write
lots of Ruby code without worrying over every detail of how the Ruby
language is designed.

## nil?

Because `nil` represents nothingness, it is often returned from
methods when there is no answer.

```ruby
[1, 2, 3].index(42) # find the position of 42 in the array
# => nil (nil isn't in the array)
```

Often we want to check whether we got `nil` back

```ruby
puts "Couldn't find answer" if [1, 2, 3].index(42) == nil
# should use include? method, but this is an example
```

Because it is so common to ask whether a value is equal to `nil`,
Object defines a special method, `nil?`:

```ruby
puts "Couldn't find answer" if [1, 2, 3].index(42).nil?
```

This works because `nil` is itself an Object. The return value of
`nil?` as defined in Object is false. `NilClass`, the class that `nil`
is an instance of, is the only class which defines `nil?` to return
true.

## Reflection methods

Objects have many methods to list their methods, check what class they
belong to, find what instance variables they hold. These methods can
be handy, but they're an advanced feature you needn't be too concerned
about right now.

One helpful method, `class`, can tell you what kind of object you're
dealing with:

```ruby
"string".class # => String
3.class # => Fixnum
some_mystery_variable.class # will tell me what kind of class this is
```

Another common method to use is `is_a?`, which will tell you if an
object is an instance of a class (or a subclass).

```ruby
"string".is_a?(String) # => true
"string".is_a?(Object) # => true (everything is an object)
```

## Resources

* [Ruby-Doc on Object](http://ruby-doc.org/core-2.1.2/Object.html)
