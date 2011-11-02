module ActiveInTime
  class Facility
    attr_reader :json

    def initialize(active_in_time, json)
      @active_in_time, @json = active_in_time, json
    end
    
    # def fetch
    #   @json = @active_in_time.get("timetables/#{id}")["timetable"]
    #   self
    # end

    def id
      @json["id"]
    end

    def name
      @json["name"]
    end
    
    
    def facility_type
      ActiveInTime::FacilityType.new(@active_in_time, @json['facility_type'])
    end
    
  end
end
