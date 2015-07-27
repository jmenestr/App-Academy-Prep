# Choosing good names

**In a nutshell: use descriptive, consistent naming.**

The better your naming, the easier it will be to refactor, extend and
maintain your code. Naming may seem more a matter of style than
anything, but it is in fact a significant determinant of code quality.
Good naming is often a reflection of good design.

Poor naming also stands out and looks unprofessional. It pays to take
a moment and think of a good name when you introduce a new variable.

## General naming guidelines

**Use meaningful identifiers.** `start_date` is 100x better than
`sd`. Be as descriptive as you can: `flight_number` is better than
`flight`. Short names can often be ambiguous and uncommunicative.

Until told otherwise, consider one letter variable names banned :-)

**Make names as long as necessary, but as short as possible.** It's
hard to give hard numbers; names >20 characters are long, but 15-20 is
totally fine.

**Avoid meaningless, vague, or wishy-washy names.** Some names have
broad meanings, and don't provide much information. Names such as
`arr`, `data`, `input` or `output` don't give much substantive
information. If you find yourself forced to use a vague name because
you can't think of one that encapsulates everything involved, maybe
the design is unclear and not logically coherent.

### Array variable names

The only time you may use a one letter variable name is as an index
into an array:

```ruby
i = 0
while i < numbers.length
  number = numbers[i]
  # ...
end
```

See how the index is `i`, but the value is `number`? Don't store the
index itself in `number`; the index is a position in the array, not an
element of the array.

Of course, you should be using `each` in this example anyway:

```ruby
numbers.each do |number|
  # ...
end
```

## Naming methods

Steve McConnell's [Code Complete][code-complete] gives a few good
guidelines that should help with method naming:

**Describe everything a method does.** And I mean everything. If your
method name becomes too long, your method does too much.

**For methods that have no side-effects and just return a value, try
using a description of the return value.** For example, method names
such as `cosine` and `square_root` are good names that explain exactly
what the method returns. Names like `calculate_cosine` and
`get_square_root` are overly verbose.

**For methods that do have side-effects, try using a verb followed by
a noun.** Describe what the method is doing, and to/with what. For
example, `print_document` or `deposit_funds`.

**Establish conventions for common operations** If there is a
prevailing convention for a common operation, defer to it. If not,
enforce consistency in your own code base. For example, don't have
different ways of getting an object's id: `supervisor.id` and
`employee.get_id`. (You shouldn't use `get_id` anyway, per the
guideline for side-effect free methods).

[code-complete]: http://www.amazon.com/Code-Complete-Practical-Handbook-Construction/dp/0735619670/

## Ruby-specific naming guidelines:

* Use `snake_case` (not `CamelCase`) when naming methods,
  variables, and files.
* Use `CamelCase` for classes and modules.
* Use `SCREAMING_SNAKE_CASE` for other constants.
* Methods that return a boolean value (i.e. `true` or `false`) should
  end with a question mark (e.g., `Array#empty?`).
* Methods that are potentially 'dangerous' (e.g., because they modify
  the calling object or arguments) should end with an exclamation mark
  (e.g., `Array#map!` changes the original array).

## Resources

* [Ruby Style Guide: Naming][naming-guide]

[naming-guide]: https://github.com/bbatsov/ruby-style-guide#naming
