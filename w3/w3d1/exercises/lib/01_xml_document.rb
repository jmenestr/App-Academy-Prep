class XmlDocument
  # TODO: your code goes here!
  def initialize(indent = false)
    @indent = indent
  end

  def method_missing(name,*attrs,&blk)
    attrs = attrs[0] || {}
    create_tag(name,attrs,&blk)
  end

  def create_tag(name,attrs,&blk)
    xml = ""
    if block_given?
      # Create nested tags if block is given
      xml << "<"+([name] + create_attrs(attrs)).join(" ")+">"
      xml << blk.call
      xml << "</#{name}>"
    else
      # Create solo tag
      xml << lone_tag(name,attrs)
    end
    xml
  end

  def lone_tag(name,attrs)
     "<"+([name] + create_attrs(attrs)).join(" ")+"/>"
  end

  def create_attrs(attrs)
    attrs.map {|key,value| %Q{#{key}="#{value}"} }
  end
end


