# Blocks and Procs

## Goals

* Know how to define a block, especially one that takes arguments.
* Know how to write a method that takes a block.
* Know the difference between blocks and [`Proc`][proc-doc]s.
* Know the difference between `break` and `return`.
* Know what `#to_proc` and `&` are used for.

[proc-doc]: http://ruby-doc.org/core-2.1.2/Proc.html

## Blocks! Blocks! Blocks!

Blocks, more than anything, are what makes Ruby unique. Blocks are
chunks of code that get passed into methods. Methods then **call** the
block to customize their own behavior.

For instance, take `Enumerable#map`:

```ruby
[1, 2, 3].map { |num| num + 1 } # => [2, 3, 4]
```

`map` applies a block to each element of the array. What it does with
each element depends on the block. For instance, instead of adding one
to each element, we could square them:

```ruby
[1, 2, 3].map { |num| num * num } # => [1, 4, 9]
```
Fundamentally, methods often take blocks to allow the user to
customize what the method will do.

## Block syntax

Blocks are either wrapped in curly braces, or with a "do" and "end". We
could write the previous example as:

```ruby
[1, 2, 3].map do |num|
  num * num
end # => [1, 4, 9]
```

Use braces for single-line blocks. *Always use do-end for longer blocks*.

Blocks are passed to a method, but they do not appear in the list of
arguments. They come after the closing parentheses, if there are any:

```ruby
3.times { puts "Hey, friend!" } # don't need parens when there are no args
3.times() { puts "Hey, friend!" } # block is given outside parens, if they are used
```

Blocks may take arguments, just like methods do. The argument names are
wrapped in `|` (*pipes*).

```ruby
[1, 2, 3].map { |num| num * num }
```

Here `map` is going to call the block repeatedly; it will pass in each
of the elements. Each time, the element (1, 2, or 3) will be *bound*
to the `num` argument declared between the pipes.

## Writing a method that takes a block

Blocks are passed to methods mostly like other arguments. Let's write a
method, `maybe` that will call a block only if its argument is true. It
should work like this:

```ruby
maybe(true) { puts "Hello!" } # runs block, since passed true
maybe(false) { puts "Goodbye!" } # doesn't run block
```

Here's how we could define `maybe`:

```ruby
def maybe(flag, &prc)
  prc.call if flag
end
```

Notice the `&prc` argument? The ampersand is a special symbol that
signifies that `prc` should hold a `Proc`. The block, if provided, gets
turned into a `Proc` object, which is then stored in the `prc` variable;
if no block is provided, `prc` is set to `nil`. We need to mark the
variable with a `&` because procs are not passed like normal
arguments; they don't appear inside the parens in the list of values
to pass in.

```ruby
def amp_makes_block_a_proc(&prc)
  puts prc.class
end

amp_makes_block_a_proc {|x| x+1}
#=> Proc
```

What's the difference between a block and a `Proc`? A block is the Ruby
code you write; it is not a real Ruby object.

Ruby will create an object that will store your block so that you can
call it later, a `Proc`. You can create a `Proc` object yourself:

```ruby
my_proc = Proc.new { "Hey, friend!" }
my_proc.call # calls the block, which returns: "Hey, friend!"
my_proc.call # calls it again
```

`Proc#call` calls the block. Any arguments you pass to `call` will be
passed on to the block.

```ruby
my_new_proc = Proc.new { |name| puts "Hello #{name}" }
my_new_proc.call("Zimmy") # prints "Hello Zimmy"
```

The `&` way only allows you to pass a single block/proc to a method. If
you want to pass multiple procs, you must pass them as normal arguments:

```ruby
proc_add_1 = Proc.new {|num| num + 1}
proc_add_2 = Proc.new {|num| num + 2}

def chain_blocks(start_val, proc1, proc2, &proc3)
  val1 = proc1.call(start_val)
  val2 = proc2.call(val1)
  val3 = proc3.call(val2)

  val3
end

chain_blocks(1, proc_add_1, proc_add_2) do |num|
  num + 3
end
```

This passes in three procs; `proc_add_1`, `proc_add_2`, and then the
third block after it has been procified.

## yield

Ruby has a special syntax which simplifies passing blocks. You may use
the keyword `yield` to call the passed block without using a block
variable. Let's rewrite `maybe`:

```ruby
def maybe(flag)
  yield if flag
end
```

My preference is to list the block in the argument list (`&` style) and
call the proc explicitly with `call`. This makes it clearer to a reader
what arguments the method can take.

If you want to check if a block is given, I usually use `prc.nil?`.
Similar to `yield`, you can use the special method `block_given?` if you
don't want to list the block in the argument list.

## Avoid return inside a block

Blocks implicitly return values like Ruby methods; the last value is
implicitly returned from the block.

```ruby
add_one = Proc.new { |num| num + 1 } # num + 1 will be returned
two = add_one.call(1)
```

This is how `Enumerable#map` works: it calls the block on each element,
using the returned value in the new collection.

Do not explicitly `return` from a block:

```ruby
[1, 2, 3].map { |num| return num + 1 } # surprise!
```

This will not merely return from the block, it will return from the
context where the block was defined. Huh? What does that mean?

The reason is not vital for you to know right now (so long as you know
not to use return in blocks!). You can skip the following if you like;
if you are curious, you read on.

```ruby
def wrap_block(&prc)
  puts "Started at #{Time.now}."
  value = prc.call
  puts "Ended at #{Time.now}."

  value
end

# example 1
def test1
  value = wrap_block do
    1 + 1
  end

  puts "All done! Got value: #{value}."
end

# example 2
def test2
  value = wrap_block do
    # this is going to return immediately *from test2*
    # will not wait for printing end time, or "Never called!"
    return 1 + 1
  end

  puts "Never called!"
end

# example 3
wrap_block do
  # Throws exception:
  #     "LocalJumpError: unexpected return"
  # Does this because it wouldn't otherwise be legal to call return at
  # the top level of our Ruby code (outside a method).

  return 1 + 1
end
```

Tricky, tricky, tricky. We might have thought we could return from the
block as if we were in a new, anonymous method. Under this theory,
return would return just from the block.

This is not what a block does, though; as said, it will return from the
context where it was first defined. In example two, this results in the
unexpected behavior. In the third example, the block is defined at the
top level, where it is illegal to return. So this causes an exception to
be thrown.

When I learned Ruby, I was surprised by this behavior. I was used to
other languages (like Lisp and JavaScript) which led me to believe
return would only return from the block. Ruby does have a way to do this
(lambdas), but they are not as commonly used as blocks.

As you grow wise with age, you may learn to recognize times where it
might be convenient to return from a block and take advantage of this
feature. For myself, I don't do this, since it is somewhat unexpected
(by me, anyway). So even when it might be otherwise convenient, I want
to be sure not to confuse another reader (or myself!) when someone comes
back to my code.

## Symbols and blocks

Methods that take a block typically don't want to accept an explicit
`Proc` object:

```ruby
add_one = Proc.new { |i| i + 1}
[1, 2, 3].map(add_one) # wrong number of arguments (1 for 0)
```

We have to make sure that Ruby understands we want to pass the proc in
as the block/proc argument, not a normal argument. To do this, we use
the `&` symbol again:

```ruby
[1, 2, 3].map(&add_one) # => [2, 3, 4]
```

Notice how this is kind of the flip-side of using `&` in the definition
of a method.

Of course, we get yelled at if we try to pass both a `Proc` this way in
addition to a typical block:

```ruby
[6] pry(main)> [1, 2, 3].map(&add_one) { "an actual block!" }
SyntaxError: (eval):2: both block arg and actual block given
```

It's very, very common to have blocks that take an argument and call a
single method:

```ruby
["a", "b", "c"].map { |str| str.upcase } # upcase all strings
[1, 2, 5].select { |num| num.odd? }
```

In this case, Ruby gives us a shortcut:

```ruby
["a", "b", "c"].map(&:upcase)
[1, 2, 5].select(&:odd?)
```

What's happening here? Using the `&` symbol calls `#to_proc` on the item
following the ampersand. For example, in the above code,
[`#to_proc`][symbol-to-proc] is called on the symbols `:upcase` and
`:odd`.

[symbol-to-proc]: http://ruby-doc.org/core-2.1.2/Symbol.html#method-i-to_proc

When `#to_proc` is called on a symbol, we get back a `Proc` object that
just calls a method with the same name as the symbol on its argument.
Here's what the above is "actually doing".

```ruby
["a", "b", "c"].map { |s| s.upcase }
[1, 2, 5].select { |i| i.odd? }
```

Here's an example of converting a `Symbol` into a `Proc`. Notice that we
can call *the same Proc* on different data structures:

```ruby
class Array
  def first_and_last
    [self.first, self.last]
  end
end

class String
  def first_and_last
    [self[0], self[-1]]
  end
end

symbolic_proc = :first_and_last.to_proc #=> #<Proc:0x007feb749b0070>
symbolic_proc.call([1,2,3]) #=> [1, 3]
symbolic_proc.call("ABCD") #=> ["A", "D"]
["Hello", "Goodbye"].map(&:first_and_last) # => [["H", "o"], ["G", "e"]]
```

Note: In order to convert a symbol to a string you can use `#to_s` or
`#to_sym` to go from string to symbol

## The different uses of `&`

You may have noticed that the `&` appears in many places in the examples
above. The `&` can be tricky because it does several things:

* Converts blocks to procs
* Converts method names (passed as symbols) to procs
* Converts procs to blocks

We have mostly seen the first two uses, but you should be aware of the
third. For example, assume we have a method `my_sort!` that takes a
block argument, like this:

```ruby
animals = ['cats', 'dog', 'badgers']
animals.my_sort! do |animal1, animal2|
  animal1.length <=> animal2.length
end
animals # => ['dog', 'cats', 'badgers']
```

We can easily define a non-bang version of this method like so:

```ruby
class Array
  def my_sort(&prc)
    self.dup.my_sort!(&prc)
  end
end
```

The two uses of `&` in the above example do different things: the first
one calls `#to_proc` on a block argument, creating a first-class proc
object that we can refer to with `prc`. But `#my_sort!` expects a block
argument, not a proc, so we can't simply pass it `prc`. Instead, when we
call `#my_sort!`, we use `&` again, but this time `&` means *the
opposite* of what it meant in the previous line; now `&` is changing the
proc back into a block.

## Required video

* Watch Peter's [Procs, Blocks and Lambdas][peter-youtube-blocks].

[peter-youtube-blocks]: http://www.youtube.com/watch?v=VBC-G6hahWA

## Resources

* [Robert Sosinski on Blocks][sosinski-blocks]
* [Skorks on Procs and Lambdas][skorks-blocks]

[sosinski-blocks]: http://www.reactive.io/tips/2008/12/21/understanding-ruby-blocks-procs-and-lambdas/
[skorks-blocks]: http://www.skorks.com/2010/05/ruby-procs-and-lambdas-and-the-difference-between-them/
