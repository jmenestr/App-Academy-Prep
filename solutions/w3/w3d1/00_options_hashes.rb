def transmogrify(word, options = {})
  defaults = { times: 1, upcase: false, reverse: false }

  options = defaults.merge(options)
  result = word

  result = result.upcase if options[:upcase]
  result = result.reverse if options[:reverse]

  result * options[:times]
end
