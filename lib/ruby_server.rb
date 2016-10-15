require "socket"

BASE_LIB_PATH = File.expand_path('..', __FILE__)

Dir["#{BASE_LIB_PATH}/ruby_server/*.rb"].sort.each do |f|
  require "#{BASE_LIB_PATH}/ruby_server/#{File.basename(f, '.rb')}"
end

module RubyServer
  def self.run
    dts = TCPServer.new('localhost', 4000)
    loop do
      Thread.start(dts.accept) do |s|
        connection(s)
      end
    end
  end

  def self.connection(s)
    request = s.gets
    if TCPServerRequest.check_method_and_url(request, :get, :time)
      begin
        body = Proc.new do
                if TCPServerRequest.request_have_params?(request)
                  paramstring = TCPServerRequest.params(request)
                  paramstring.each do |city|
                    City.new(city, s).say_time
                  end
                end
              end
        RenderContent.wrap_content(s, body)
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
    end
    s.close
  end
end


RubyServer.run
