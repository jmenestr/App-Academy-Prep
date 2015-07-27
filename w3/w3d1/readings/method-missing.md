# `method_missing`

When a method is called on an object, Ruby first looks for an existing
method with that name. If no such method exists, then it calls the
`Object#method_missing` method. It passes the method name (as a
symbol) and any arguments to `#method_missing`.

The default version simply raises an exception about the missing
method, but you may override `#method_missing` for your own purposes:

```ruby
class T
  def method_missing(*args)
    p args
  end
end
```

```ruby
1.9.3p194 :007 > T.new.adfasdfa(:a, :b, :c)
[:adfasdfa, :a, :b, :c]
```

Here's a simple example:

```ruby
class Cat
  def say(anything)
    puts anything
  end

  def method_missing(method_name)
    method_name = method_name.to_s
    if method_name.start_with?("say_")
      text = method_name[("say_".length)..-1]

      say(text)
    else
      # do the usual thing when a method is missing (i.e., raise an
      # error)
      super
    end
  end
end

earl = Cat.new
earl.say_hello # puts "hello"
earl.say_goodbye # puts "goodbye"
```

Using `method_missing`, we are able to "define" an infinite number of
methods; we allow the user to call any method prefixed `say_` on a
`Cat`. This is very powerful. However, overriding `method_missing` can
result in difficult to understand/debug to code, and should not be
your first resort when attempting metaprogramming. Only if you want
this infinite expressibility should you use `method_missing`; prefer a
macro if the user just wants to define a small set of methods.

`method_missing` is a cool trick, but I don't know that I've used it
in any of my professional projects. I do know that understanding it
helped me understand how Rails dynamic finders work.

### An advanced example: dynamic finders

Rails, for instance, has a way of finding objects through
`method_missing`:

```ruby
User.find_by_first_name_and_last_name("Ned", "Ruggeri")
User.find_by_username_and_state("ruggeri", "California")
```

Rather than create a method for every single possible way to search
(which is almost infinite), Rails overrides the `#method_missing`
method, and for `find_by_*` methods, it then parses the method name
and figures out how it should perform the search. Here's how it might
do this:

```ruby
class User
  def method_missing(method_name, *args)
    method_name = method_name.to_s
    if method_name.start_with?("find_by_")
      # attributes_string is, e.g., "first_name_and_last_name"
      attributes_string = method_name[("find_by_".length)..-1]

      # attribute_names is, e.g., ["first_name", "last_name"]
      attribute_names = attributes_string.split("_and_")

      unless attribute_names.length == args.length
        raise "unexpected # of arguments"
      end

      search_conditions = {}
      attribute_names.each_index do |i|
        search_conditions[attribute_names[i]] = args[i]
      end

      # Imagine search takes a hash of search conditions and finds
      # objects with the given properties.
      self.search(search_conditions)
    else
      # complain about the missing method
      super
    end
  end
end
```
