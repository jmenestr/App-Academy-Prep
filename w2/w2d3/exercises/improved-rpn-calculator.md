# RPN Calculator with I/O

You've written an RPN calculator. Now it's time to go back, refactor,
and improve it by adding some new functionality. You can do this in your
existing RPN calculator Ruby file. You should be able to invoke your
modified calculator as a script from the command line. You should be
able to, optionally, give it a filename on the command line, in which
case it opens and reads each line in that file:

```
# calculator_instructions.txt
5 2 + 4 *
1 2 * 1 +

# command prompt
~$ ruby 12_rpn_calculator.rb calculator_instructions.txt
28 #=> printed result
3  #=> printed result
```

If no filename argument is passed, it should have a user interface that
reads from standard input one operand or operator at a time. If the user
hits `enter` with no operand, the calculator should run and output its
result.

```
~$ ruby 12_rpn_calculator.rb
5
2
+
4
*

28 #=> printed result, program ends
```

For the moment, there aren't tests for the IO functionality of the
calculator. Just make sure that it continues to pass the original specs,
and play around with file/command line input on your own to make sure
that it works. It will be a good exercise in debugging!

**NB**: If you write your user interaction code right at the bottom of
the file, you will almost certainly cause the specs to fail. This is
because, when RSpec `require`s your RPN calculator file, that code will
be run (and RSpec will get stuck waiting for `gets`). You can avoid the
issue by wrapping your code like so:

```rb
if __FILE__ == $PROGRAM_NAME
  # your code here
end
```

Without going into too much detail: the `__FILE__ == $PROGRAM_NAME`
condition will only evaluate to `true` if you are invoking the file
directly from the command line (i.e., `ruby 12_rpn_calculator.rb`). It
will evaluate to `false` if the file is loaded in some other way
(through the debugger, in pry, or through a `require` statement). If you
use this snippet, you will be happy (because you can play with your
calculator), and RSpec will be happy (because it can load and test your
file). Great success!
