module RubyServer
  module TCPServerRequest
    def self.check_method_and_url(request, method = :get, url = 'time')
      request.match(/#{method.to_s.upcase} \/#{url.to_s}/)
    end

    def self.request_have_params?(request)
      request.match(/\?/)
    end

    def self.params(request)
      paramstring = request.split('?')[1]
      paramstring = paramstring.split(' ')[0]
      paramstring = paramstring.split(',')
    end
  end
end
