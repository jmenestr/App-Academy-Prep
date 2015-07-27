# Classes

## Goals
- Know that a class is a blueprint for an object.
- Know how to extend a class.

## What is a class?

A class is simply a blueprint for an object. It provides the definitions
for all of the object's methods, as well as a set of instructions for
how the object is constructed and how it stores information. As we've
said before, everything in Ruby is an object, and classes are no
exception. Interestingly, `Class` is itself an instance of `Class`. Wow,
meta!

```ruby
[2] pry(main)> Class.is_a?(Object)
=> true
[3] pry(main)> Class.class
=> Class
```

## Extending a class

It is possible to add functionality to a class by **extending** (or
**monkey-patching**) it. We can accomplish this by opening up the class
definition and writing our new method definitions inside of it, like so:

```ruby
class String
  def palindrome?
    self == self.reverse
  end
end
```

Luckily, opening up the `String` class definition doesn't overwrite the
existing version of the class; all the built-in `String` functionality
remains intact. All we've done here is add a new method, `palindrome?`,
to what was already there. Note that this isn't like defining a method
on its own at the root level (global scope): the `palindrome?` method
can only be called on an instance of the `String` class. You'll notice
that we use a special variable called `self` inside of the method
definition. `self` refers to the object on which the current method is
being called. Say we run the following code:

```ruby
[6] pry(main)> "foo".palindrome?
=> false
```

When the `palindrome?` method gets called on `"foo"`, we enter the
method body. Since `palindrome?` was called on `"foo"`, `"foo"` is the
**receiver** of the method call. Therefore, at this point in the
program, `self` points to `"foo"`. Since `"foo"` is not equal to
`"foo".reverse`, the method returns false.
