require 'timezone'

module RubyServer
  module Timezones
    def self.timezone_by_city_name(city_name)
      city = Timezone.names.select{ |i| i =~ /#{city_name}/i }
      city.empty? ? nil : Timezone[city.first]
    end
  end
end
