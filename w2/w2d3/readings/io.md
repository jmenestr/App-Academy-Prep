# Input/Output

## Goals

* Know how to use `gets` to read input.
* Know why `chomp` is often used to clean input.
* Know the difference between `print` and `puts`.
* Know how to open a file
  * Know how to read a line from a file.
  * Know how to read in all the lines from a file.
  * Know how to slurp in a whole file in one go.
* Know when you have to close a file explicitly.
* Know how to access arguments given to your script from the command
  line

## Standard IO

The most basic IO methods are [`Kernel#gets`][gets-doc] and
[`Kernel#puts`][puts-doc]:

```ruby
input = gets
puts input # put it back out
```

[gets-doc]: http://www.ruby-doc.org/core-2.1.2/IO.html
[puts-doc]: http://www.ruby-doc.org/core-2.1.2/IO.html

`gets` will read a line from the **standard input**, which is usually
the terminal the user is typing into. It returns the string the user
typed, including the **newline character** (newline character is the
'return' character, written `"\n"`)

```ruby
input = gets # I type Hello world!, and press enter
# input == "Hello world!\n"
```

Because the newline is often undesired, frequently we use
`String#chomp` to remove it

```ruby
input = gets.chomp
# get a string from the input, chop off the newline, store it in
# input
```

`print` converts its argument to a string by calling `Object#to_s`,
then it writes it out to the standard output.

```ruby
print "this that other" # prints 'this that other' to console
print [1, 2, 3] # prints '[1, 2, 3]' to console
```

`print` doesn't add a newline after it prints output, which means
consecutive calls to `print` all print to the same line.

```ruby
print "this"
print "that" # => prints "thisthat"
print "\n" # => adds a newline
print "I'm on a new line"
```

Since it's common to want to add newlines to the end, Ruby has another
method `puts`. It's pretty simple:

```ruby
puts "this" # => prints "this" with a newline
```

Finally, there is the `Kernel#p` method, which is like `puts`, but is
used for debugging and the REPL (REPL means **read-eval-print loop**;
irb is the standard Ruby REPL). Instead of calling `Object#to_s`, `p`
calls `Object#inspect`. The main difference is:

```ruby
puts "this" # => prints "this" with a newline
p "this" # => prints '"this"' with a newline; note the quotes
```

Notice also that `puts` adds newlines after each object in an array.

```ruby
puts [1, 2, 3]
# prints:
# 1
# 2
# 3
```

If you want to print an array out on one line, you probably want `p`.

## Opening a file

You often want to read data in from files, rather than the
console. The typical way to open a file is as follows:

```ruby
File.open("movie-times.txt") do |f|
  first_line = f.gets.chomp
  # ...
end
```

The class method `File::open` opens a file. You pass a block, and the
block will be called with a `File` object passed in. To read data from
a file, you can call `File#gets`, which works like `Kernel#gets`,
except it reads from the file, rather than console.

If, as is often the case, you want to do something once for each line:

```ruby
File.foreach("movie-times.txt") do |line|
  # ...
end
```

Finally, if you'd like to read the entire file into one long string,
you may write:

```ruby
contents = File.read("movie-times.txt")
```

To read the lines individually, use `readlines`:

```ruby
contents = File.readlines("movie-times.txt")
# returns an array, with each element representing a line of
# "movie-times.txt"
# Note: Each element will end with '\n'
```

The `File` class includes `Enumerable` adding all the power we know
and love from arrays. Here's an example of using `#each`.

```ruby
f = File.new("todos")
f.each {|line| puts "#{f.lineno}: #{line}" }
```

## Writing a file

To open a file for writing, you need to pass `"w"` to `File.open` for
write mode:

```ruby
File.open("cool-things.txt", "w") do |f|
  f.puts "Race cars"
  f.puts "Lasers"
  f.puts "Aeroplanes"
end
```

Note: `"w"` mode will create a new file or overwrite an existing
file. If you wish append to an existing file, you will need to use
`"a"`. For more file mode options check
[this SO post][so-file-open-modes].

[so-file-open-modes]: http://stackoverflow.com/questions/3682359/what-are-the-ruby-file-open-modes-and-options?answertab=votes#tab-top

## Closing files

The examples I've shown you have all automatically **closed** the file
when done. It is important to close files when you are finished with
them; this doesn't matter so much for reading (it is merely
inefficient), but if you don't close a file you are writing to, then
the whole output may not be written to disk, and you may lose data.

If you use `File::open` without a block, it returns an open `File`
object. You'll be responsible for calling `#close` when you're done.

```ruby
f = File.open("cool-things.txt", "w")
f.puts "Race cars"
f.puts "Lasers"
f.puts "Aeroplanes"

# will make sure output is "synced" to disk and properly saved
f.close
```

Because it is error-prone to rely on remembering to `#close` a file,
prefer the block version of `::open`, `::foreach`, or `::read`
whenever possible. These will all automatically `#close` the file.

## Standard Output and Input

We've seen the methods `Kernel#puts` and `Kernel#gets` as well as
`File#puts` and `File#gets`. Surprise! They're related!

In \*nix operating systems (like Linux, BSD, and OS X), the console
input and output are just special files. You can read and write to
them like any other file. These are called *standard input* and
*standard output*.

In Ruby, you can access standard input and output through the global
variables `$stdout` and `$stdin`. These variables just hold typical
`File` objects. In particular, `Kernel#gets` and `Kernel#puts` just
call `$stdin.gets` and `$stdout.puts`.

Remembering that `$stdin` is a `File` object and that `File` objects
include `Enumerable` you'll realize that you can `#each` over input.

```ruby
$stdin.each do |input|
  puts "I was given: #{ input }"
end
```

## Command Line Arguments

A user can pass arguments to your script from the command line. For
example, if your script counts a list of cats, the user could pass the
name of a file that contains a list of cats:

```
$ ruby my_cat_counter.rb list_of_cats.txt
```

To access the filename passed in, use `ARGV` in your script.
[ARGV][ARGF-doc] returns an array of strings that were typed after
your script name. Example:

```ruby
puts ARGV
# returns ["list_of_cats.txt"]
puts ARGV[0]
# prints "list_of_cats.txt"
```

[ARGF-doc]: http://www.ruby-doc.org/core-2.1.2/ARGF.html#method-i-argv

## Resources

* *Beginning Ruby* (Ch. 9, p. 203 in the 2nd Edition)
* [Ruby IO Class](http://ruby-doc.org/core-2.1.2/IO.html)
