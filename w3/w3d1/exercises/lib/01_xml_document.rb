class XmlDocument
  # TODO: your code goes here!
  def initialize(indent = false)
    @indent_flag = indent
    @indent_level = 0
  end

  attr_reader :indent_flag, :indent_level

  def method_missing(name,*attrs,&blk)
    attrs = attrs[0] || {}
    create_tag(name,attrs,&blk)
  end

  def create_tag(name,attrs,&blk)
    xml = ""
    if block_given?
      # Create nested tags if block is given
      xml << open_tag(name,attrs)
      @indent_level += 1
      xml << blk.call
      @indent_level -= 1
      xml << close_tag(name)
    else
      # Create solo tag
      xml << lone_tag(name,attrs)
    end
    xml
  end

  def lone_tag(name,attrs)
     "#{indent}<"+tag_body(name,attrs)+"/>#{newline}"
  end

  def open_tag(name,attrs)
    %Q{#{indent}<#{tag_body(name,attrs)}>#{newline}}
  end

  def close_tag(name)
    %Q{#{indent}</#{name}>#{newline}}
  end

  def tag_body(name,attrs)
    ([name] + create_attrs(attrs)).join(" ")
  end

  def indent
    "  " * @indent_level if indent_flag
  end

  def newline
    indent_flag ? "\n" : ""
  end

  def create_attrs(attrs)
    attrs.map {|key,value| %Q{#{key}="#{value}"} }
  end
end


