module ActiveInTime
  class TimetableSession
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
    
    def timetable_session_category
      return nil if !@json['timetable_session_category']
      ActiveInTime::TimetableSessionCategory.new(@active_in_time,@json['timetable_session_category'])
    end
    
  end
end
