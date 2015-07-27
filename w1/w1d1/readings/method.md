# Methods

## Goals
- Know what a method is.
- Be familiar with some methods of Ruby's built-in classes.
- Know how a method is different from a function.
- Know what side effects and return values are.
- Know what an implicit return is, and that they are preferred.
- Know some signs of a good method:
  - it does one thing
  - it has a short description and a good name
  - its body is under 10 lines long

## What are functions and methods?
In computer programming, both **functions** and **methods** are blocks
of code referred to by name. By convention, methods are associated with
(and called on) an object, while functions are not. Since Ruby is a
purely object-oriented language, it does not have any functions as such;
only methods. `puts`, `Array#length`, and `String#chomp` are examples of
methods you've probably already used.

## Side-effects and return values

When a method is called, the code inside of its body is run, and the
method's **return value**, if any, is passed back to the code that
called the function. In Ruby, **every method has a return value**.
Sometimes, the return value is meaningful, and sometimes it isn't (often
the return value is `nil` in this case). Let's take a look at a few
examples to see how this plays out:

Here's an example of a method that returns the square of a
number:

```ruby
def square(num)
  num * num
end
```

Notice that there we don't say `return num * num` (an *explicit
return*). Ruby has *implicit returns*; that is, **the last evaluated
expression in a method is the return value of that method**. Because of
implicit returns, we only use explicit returns when we want to break out
of a function early, such as in the following method:

```ruby
def go_home
  return unless can_go_home? && wants_to_go_home? # stops execution of
  the function if the condition is satisfied

  pack_bags
  get_tickets
  board_plane
end
```

There are also methods that return nothing; these we use for their
side-effects. When we say side-effect, we mean some sort of
modification to a non-local variable or some sort of observable
interaction with the outside world.

A great example of a method that is used for its side effect is `puts`,
which prints its arguments to the console but returns `nil`. Another one
is `each`. `each` returns the original array, which provides no new
information and is therefore not terribly useful; thus it is used
exclusively for its side-effects.

## Good methods are short, simple and coherent

Your methods should be as simple as possible. In particular, they
should do one thing; you should be able to explain what it does in a
single sentence. You should be able to give it a straightforward,
descriptive name. Another sign of a good method is that it is <10 lines.
The primary way to achieve this is to break code up into several shorter
methods.

In computer science, there is no greater quality than code that is
easy to understand. Make a start by keeping your methods short and
sweet.
