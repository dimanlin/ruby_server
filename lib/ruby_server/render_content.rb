module RubyServer
  module RenderContent
    def self.wrap_content(s, content)
      s.write('<html>')
      Response.current_location(s)
      s.write('<br/>')
      content.call
      s.write('</html>')
    end
  end
end
