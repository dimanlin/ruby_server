module RubyServer
  module Response
    def self.city_not_exist(city, s)
      s.write("#{city} - does not exist")
    end

    def self.city(city, s, timezone)
      time = timezone.utc_to_local(Time.now)
      s.write("#{city} #{time}")
    end

    def self.current_location(s)
      s.write("Current location #{Time.now}")
    end
  end
end
