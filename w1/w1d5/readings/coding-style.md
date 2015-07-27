# Coding style

## Goals

* Always follow these most important rules:
    * Indent your code.
    * Limit lines to 72 chars.
    * Avoid long methods and nesting more than two levels deep.
    * Don't over-comment.

## Style matters

People have been writing code for a while, and there is an established
way of doing things. You are new, so you're just learning these
conventions. They may seem arbitrary and silly; some of them
are. Others really do represent common sense.

It is very important to learn and follow style rules. If you write
stylish code, it will make you look professional and capable. If not,
you'll look inexperienced.

Luckily it's easy to follow the rules; just make sure you start doing
it now so that you start building the habit of stylish coding.

I list the most important rules here, in roughly declining order of
importance. I also link a more comprehensive code style guide at the
end. Long term, the best way to learn good style is to read a lot of
code, and emulate your predecessors. Make your code look like theirs.

## Indentation

Many new programmers do not indent their code, because they haven't
written enough code to understand that it really does help
interpreting and understanding the code. It is a cardinal sin not to
indent your code. Unindented code looks really, really bad to an
experienced dev.

```ruby
class CrazyClass
  # indent classes
  def my_method
    # indent methods
    i = 0
    while i < 10
      # indent loops
      puts "Hello!"
    end

    # count in
    4.times do |n|
      # indent blocks
      puts "#{n}!"

      # see how the ends always align with the start 
      # of the indented section?
    end
  end
end
```

Indent with *two spaces*, not with tab stops. Set Atom to do this by
default; in the Settings check **Soft Tabs** (which uses spaces
instead of tabs) and **set Tab Length to 2** (use two spaces; four is
too many!).

## Keep Lines Short

Keep your lines <72 characters long. There are historical reasons to
do this; shorter lines are also (said to be) easier to read. Long
lines make you look like a yahoo or, worse, a Java developer (I was a
Java dev once).

```ruby
class CrazyClass
  def crazy_method
    i = 0
    while i < 100
      "this is my long string".a_long_method_name(a_few_arguments, and_then, it_gets_too, long).should_have_split(this_up, a_while, ago)
    end
  end
end
```

To help you, set **Preferred Line Length** in the Atom Settings
to 72. You may also have to enable the **Wrap Guide** package. This
should show a vertical line at 72 characters; don't write code past
the vertical line.

### No trailing whitespace

Don't leave extraneous whitespace (spaces or tabs) at the ends of
lines. Atom will help you by stripping trailing whitespace when you
save. You can configure this in Settings, by searching for the
**Whitespace** package.

## Avoid very long methods, deep nesting

We'll talk about it more in another chapter, but long methods are
bad. If a method is >8 lines long, you should consider whether it
might be broken into smaller methods. If your method is >20 lines
long, it is too long. >40 lines and it's a beast; you need to break
this up.

New developers may write methods that are hundreds of lines. Don't do
that.

Deep nesting often goes hand-in-hand with long methods. Deep nesting
is hard to read:

```ruby
while this
  if that
    array.map do |el|
      if other
        # whoa way too deep
```

Three levels deep is plenty deep already. Break this up into smaller
methods of one or two levels each.

## Avoid over-commenting

**This**: "Good code is like a good joke: it needs no explanation."

Do not comment trivial stuff. This code shouldn't have had any
comments at all:

```ruby
# set i to zero
i = 0

# loop while i < 100
while i < 100
  # print i
  puts i

  # increment i
  i += 1
end
```

Don't tell your reader something obvious; assume they can read
code. Use comments when the code is not obvious: when it's tricky. Of
course, avoid tricky code, but if you can't, document it.

## Add line breaks appropriately

Don't double space your code; the extra space will look silly.

Your methods should be short anyway, but it can be hard to follow many
lines of code with no line breaks. This is a subtle thing, but my
personal style is to add blank lines when I shift from one idea to
another. It works like a paragraph that way. For instance:

```ruby
def my_method
  i = 0
  while i < 100
    square = i * i
    if square % 2 == 0
      puts "Even square: #{square}"
    end

    i += 1
  end
end

def another_method
  # etc.
end
```

See how I separate the incrementing from the true "body" of the while
loop? They're separate concerns, so I want to take a breath there.

Likewise, you should always have a
blank line before a method definition.

As ever, your best guide is other people's code. Look especially at my
code, since I'm the one who will bug you about it :-)

## do/end vs {}

When you write blocks, use `{}` notation for one liners, and
`do`/`end` for multi-line blocks.

## Only use return to stop early

You should know that the return value of a method's last evaluated
line is implicitly returned by the method. In particular, you don't
need to use `return` at the end of every method.

The only time you should use `return` is if you need to stop executing
the method somewhere in the middle of the code.

## Interpolate, don't concatenate

```ruby
"my favorite number is " + favorite_number.to_s + "!" # nooooo
"my favorite number is #{favorite_number.to_s}!" # yessss
```

## References

Batsov's [style guide][bbatsov-style] is a good one to skim. 

Writing clean code is essential. Well formatted code is just
as important as using proper grammar and punctuation.
If you want people to understand your work and take you seriously
as an engineer your code must look clean, consistent, and organized.

[bbatsov-style]: https://github.com/bbatsov/ruby-style-guide
