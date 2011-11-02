module ActiveInTime
  class FacilityType
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
    
    def facility_type_category
      ActiveInTime::FacilityTypeCategory.new(@active_in_time, @json['facility_type_category'])
    end
    
  end
end
