# Enumerable

## Goals

* Know that any `Enumerable` method can be called on an `Array` or
  `Hash`.
* Familiarize yourself with the selected, important methods here.
* Know the difference between `each` and `map`, and when to use them.

## What is `Enumerable`?

`Enumerable` is a Ruby module. A **module** is a collection of methods
(and constants). Modules can be **mixed in** to other classes; this
just means that the module's methods are available in the class that
it is mixed into. We will eventually write our own modules, but for
now it suffices to know that we put methods in a module when we want
to be able to use them in various different classes.

`Enumerable` is one of the most powerful modules in Ruby; it holds
killer methods such as `map` and `each`. Because `Enumerable` is mixed
into `Array` and `Hash` (as well as other classes), these Enumerable
methods are available on both `Array` and `Hash`.

Let's take a look at some of the most commonly used and powerful
methods in the `Enumerable` module.

### `Enumerable#each`

You've already seen this before! If you want a refresher, just look at
the [Hash](hash.md) and [Array](array.md) pages. You'll want to use
`each` when you want to run some block of code for each element in an
Array (or Hash).

### `Enumerable#map`

`map` (less commonly known by its synonym, `collect`) returns a new
array with the results of running the called block once for each
element. For example:

```ruby
integers = [1, 2, 3, 4]
integers.map { |i| i*i }
# => [1, 4, 9, 16]

nato = {:a => "alpha", :b => "bravo"}
nato.map { |key, value| value.upcase }
# => ["ALPHA", "BRAVO"]
```

On the surface, `map` and `each` look the same. They aren't! `each`
returns the **original array**, while `map` returns a **new array**
filled with newly computed values. **Neither method modifies the
original array.** To illustrate:

```ruby
integers = [1, 2, 3, 4]

map_return_value = integers.map { |i| i*i }
map_return_value # => [1, 4, 9, 16]

each_return_value = integers.each { |i| i*i }
each_return_value # => [1, 2, 3, 4]
```

Because `#each` just returns the old value, it is used for its
*side-effect*. Use `#each` if all you want is a side-effect, use
`#map` if you actually want to use the returned values.

### `Enumerable#inject`

`inject` (less commonly known as `reduce`) is a little complicated. I
am not personally in love with it, because it can make code harder to
understand. That said, you'll see it from time to time.

Let's start by looking at an example of how you'd use inject to sum
all the elements in an array:

```ruby
nums = [1, 2, 3, 4, 5]
nums.inject(0) do |accum, element| # accum is initially set to 0, the method argument
  accum + element
end

nums.inject(:+) # A cool shortcut that does the same as the above code. 

# Write a method that takes nums and, using inject, returns the
# product of all of the elements.
```

We pass `inject` an initial value and a block. The code block takes
the current **accumulator** value and the next element in the
`Enumerable`. The block is run, and the accumulator value is updated
with the block's result. When all elements have been processed, the
accumulator value is returned.

I personally would just use a loop.

### `Enumerable#select`

`select` (less commonly known as `find_all`) returns an array with all
the elements for which the called code block returns true. Let's look
at an example:

```ruby
nums = (1..10)
# nums is a Range. Ruby's Range class also mixes in Enumerable!

nums.select { |i| i % 3 == 0 }
# => [3, 6, 9]

# Write a method that takes a range of the integers from 1 to 100
# and uses select to return an array of those that are perfect
# squares.
```

### `Enumerable#count`

`count` returns the number of items in the collection it's called on.
For example:

```ruby
nums = [1, 4, 5, 6, 7]
nums.count # => 5

elements = {:first => "hydrogen", :second => 'helium', :third => 'lithium'}
elements.count # => 3
```

In a hash, `count` returns the number of key-value pairs.

### `Enumerable#include?`

`include?` takes an object as a parameter and returns true if any item
in the collection is equal to that object. Let's see it in action:

```ruby
nums = [1, 4, 5, 6, 7]

nums.include?(3) # => false
nums.include?(4) # => true
```

### `Enumerable#any?`

`any?` returns true if the code block returns true for any of the
members of the collection. Here's an example of how we can check to
see if a given array has any even numbers:

```ruby
nums = [2, 3, 5, 7]

nums.any? { |i| i % 2 == 0 }
# => true

# Using any?, verify that the range of integers from 1 to 5 does
# include at least one odd number
```

The methods `all?` and `none?` work similarly.

## Resources
* [Ruby-Doc on Enumerable](http://ruby-doc.org/core-2.1.2/Enumerable.html)
