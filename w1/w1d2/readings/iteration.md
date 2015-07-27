# Iteration

## Goals

* Know what an index variable is.
  * Know that index variables conventionally start at zero.
* Know how to write a `while` loop.
  * Know how to emulate `Array#each` with a `while` loop, if you had
    to.
  * Know that `Array#each` is preferred and why.
* Know how to break out of a loop.
* Know when you might want to use `Array#each_with_index` instead of
  `#each`.
* Know how to use `Integer#times` to execute a block multiple times.
* Know what a `Range` is.
  * Know how we can use a `Range` to iterate through a range of index
    values, without using `while`.
* Be comfortable nesting loops when necessary.
  * Know not to nest too deeply.

## While loops

The most primitive loop is the `while` loop. It repeats a section of
code repeatedly as long as a condition is true. For instance,

```ruby
while true
  puts "Infinite loop!"
end
```

will spin round and around repeatedly, forever. Most loops eventually
stop, however:

```ruby
i = 0
while i < 5
  puts "Repeat 5 times!"
  puts "This is time #: #{i}"

  i += 1
end

puts "Merry Christmas, loop is over!"
```

This is a very traditional loop. `i` is called the **index**, and it
keeps track of how many times we've gone through the loop.

`i` starts at zero, because we've gone through the loop zero
times. The loop will keep running so long as `i < 5`; that is, we'll
keep looping until we've executed the code block (the stuff between
the `while` and the `end` lines) five times. Each time around, at the
end of the loop block, one is added to `i`. After the first time
through the block, `i` is set to one, and the program jumps back to
the top of the `while`. Since one is still less than five, the loop
repeats.

`i` takes on, or **iterates** through the values 0,1,2,3,4,5. After
the fifth time around the loop, `i` is set to five (not four, not six;
convince yourself of this).

The loop finally comes back around for the *sixth* time to the while
test. Remember, `i` has just been set to five. `i < 5` is no longer
true. So the code block is not executed and the loop exits, so that
the code following the loop's `end` is run.

This is the most basic loop. If all else fails, you can always fall
back on this. All the other loop forms are just more convenient forms
of this basic loop style.

### Indices start at zero

We could have changed our loop ever so slightly:

```ruby
i = 1
while i <= 5
  puts "Repeat 5 times!"
  puts "This is time #: #{i}"

  i += 1
end
```

This would do the almost the same thing as our previous loop; verify
this for yourself.

Don't write loops with indices starting at one; you'll confuse other
programmers. Indices have started at zero for a long time, and it's
what other programmers are used to. It's also the range of array
indices you'd want (the indices into an array of ten items is
0-9).

This is called an **idiom**; idioms are coding conventions that are
commonly used. They are a good thing, because conventions we've seen
before are easier to understand when we see them again.

### While without an index

So far we've only seen `while` loops that loop through index
values. In fact, we'll see there are better ways to do this, so we
shouldn't use a `while` loop for this purpose. A `while` loop is
usually used, however, when we want to keep doing something in a loop,
keep looping until something happens, but don't know exactly how many
times around that may be.

Example:

```ruby
def process_user_input
  command = get_user_input
  while command != "quit"
    perform_command(command)

    command = get_user_input
  end

  puts "Good bye!"
end
```

This will loop through as many commands as the user enters, up until
he or she instructs the program to quit.

Notice that the "update" of `command` happens at the end of the
`while` loop? This is a typical pattern; we check the condition,
perform the relevant code, then update a loop variable. Wash, rinse,
repeat...

## Break

Let's search an array of numbers for a favorite number.

```ruby
def contains_favorite_number?(my_favorite_number, numbers_to_search)
  i = 0
  while i < numbers_to_search.count
    current_number = numbers_to_search[i]

    if my_favorite_number == current_number
      puts "List contains favorite number!"
      break # jump out of the loop
    end

    i += 1
  end

  puts "If we found the number, you should know by now."
end
```

The `break` keyword jumps out of the loop. This means that the loop
will end as soon as we find our favorite number. In this case, we save
extra cycles going through the loop, and we make sure we print out
"Found my..." at most once.

## Iterating through arrays with each

If you have an array, and want to loop through all the items, you
could write:

```ruby
musicians = ['George', 'Paul', 'John', 'Ringo']

i = 0
while i < musicians.length
  puts musicians[i]

  i += 1
end
```

Instead, you should write:

```ruby
musicians.each do |musician|
  puts musician
end
```

The lines between the `do` and `end` are a code block to repeat for
each of the elements of the array. For each element in the array, the
`each` method sets the musician variable to the current element, then
executes the code block.

The biggest advantage of `each` is that you don't have to keep track
of an index variable. This may not seem like a big deal, but every
line of code you don't have to write is one less to debug.

In particular, one of the most common programming errors is to forget
to increment the index variable each time:

```ruby
i = 0
while i < 5
  puts "Do this five times"

  # forgot: i += 1
end
```

### `each` vs `for`

Ruby also has a `for` loop construct:

```ruby
for item in items
  # ...
end
```

For boring reasons, `for` is not recommended for use. You'll see
plenty of Python code use `for` this way, but in Ruby we'll satisfy
ourselves with using `#each`.

## `each_with_index`

`each` is cleaner than `while`, but sometimes you also need the index
of each element. In this case, you should use `each_with_index`:

```ruby
my_favorite_number = 42
numbers = [42, 3, 42, 5]

favorite_indices = []
numbers.each_with_index do |number, index|
  if number == my_favorite_number
    favorite_indices << index
  end
end
```

`each_with_index` combines the simplicity of `each` with the ability
to reference an index.

## Iterating with times

If all you want to do is repeat some code several times, use Ruby's
`times` method:

```ruby
5.times do
  puts "King of the streets; child at play"
end
```

Again, you get to avoid an index variable.


## Range

A range is exactly what it sounds like:

```ruby
(1..10)
```

This represents all the numbers from 1 through 10. A range with two
dots goes up to and includes the second number. A range with three
dots excludes the seconds number. For example, (0...10) goes from 0 to
9, and does not include 10. We can iterate over ranges just like we
iterated over arrays:

```ruby
(1..10).each do |i|
  puts i * i
end
```

Note that ranges cannot go from a larger value to a smaller value
(i.e. `10..1`).

```ruby
(10..1).to_a
=> []
```

One alternative is to convert the range to an array and reverse it:

```ruby
(1..10).to_a.reverse.each do |i|
  puts i
end
```

In this case, it probably makes more sense to use
[`Integer#downto`][downto-doc].

[downto-doc]: http://ruby-doc.org/core-2.1.2/Integer.html#method-i-downto

## Nesting loops

Loops can be placed inside each other, or *nested*. Here are some
nested loops that print out a times table:

```ruby
(1..10).each do |i|
  multiples = []
  (1..10).each do |j|
    multiples << i * j
  end

  p multiples
end
```

Note: when you have two indices, `i` and `j` are conventional
names. However, they are often the lazy way out: unclear, abstract
index names are a major source of confusion and bugs. Here names like
`num1` and `num2` would make things clearer.

*Avoid deep nesting*. Nested code should be split out into
methods. Two levels deep is usually okay, more is almost always
bad. For instance, we could change our times table code like this:

```ruby
def multiples(i)
  ms = []
  (1..10).each do |j|
    ms << i * j
  end

  ms
end

(1..10).each do |i|
  p multiples(i)
end
```

## Resources

* [Skorks on looping][skorks-loops]
* More examples of loops on [tutorialspoint][tutorialspoint]

[skorks-loops]: http://www.skorks.com/2009/09/a-wealth-of-ruby-loops-and-iterators
[tutorialspoint]: http://www.tutorialspoint.com/ruby/ruby_loops.htm
