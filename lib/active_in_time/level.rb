module ActiveInTime
  class Level
    attr_reader :json

    def initialize(active_in_time, json)
      @active_in_time, @json = active_in_time, json
    end

    def id
      @json["id"]
    end

    def name
      @json["name"]
    end
    
  end
end
