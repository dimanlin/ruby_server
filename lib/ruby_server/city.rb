require 'uri'

module RubyServer
  class City
    attr_writer :city_name
    attr_writer :s

    def initialize(city_name, s)
      @city_name = city_name.gsub('%20', '_')
      @city_human_name = URI.decode(city_name).capitalize
      @s = s
    end

    def say_time
      if @city_name == 'current_location'
        say_time_for_current_location
      else
        say_time_for_real_city
      end
    end

    private

    def wrap_content(&block)
      @s.write('<html>')
      yield
      @s.write('</html>')
    end

    def say_time_for_real_city
      wrap_content do
        timezone = RubyServer::Timezones.timezone_by_city_name(@city_name)
        if timezone.nil?
          Response.city_not_exist(@city_human_name, @s)
        else
          Response.city(@city_human_name, @s, timezone)
        end
        @s.write('<br/>')
      end
    end

    def say_time_for_current_location
      wrap_content do
        Response.current_location(@s)
      end
    end
  end
end
