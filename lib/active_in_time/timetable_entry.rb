require 'time'
require 'date'

module ActiveInTime
  class TimetableEntry
    attr_reader :json

    def initialize(active_in_time, json)
      @active_in_time, @json = active_in_time, json
    end
    
    def fetch
      @json = @active_in_time.get("timetables/#{timetable_id}/timetable_entries/#{id}")["timetable_entry"]
      self
    end

    def id
      @json["id"]
    end
    
    def start_time
      Time.parse(@json["end_time"])
    end
    
    def end_time
      Time.parse(@json["end_time"])
    end
    
    def date
      Date.parse(@json["date"])
    end
    
    def term_type
      ActiveInTime::TermType.new(@active_in_time,@json['term_type'])
    end
    
    def timetable_session
      return nil if !@json['timetable_session']
      ActiveInTime::TimetableSession.new(@active_in_time,@json['timetable_session'])
    end
    
    def instructor
      return nil if !@json['instructor']
      ActiveInTime::Instructor.new(@active_in_time,@json['instructor'])
    end
    
    def level
      return nil if !@json['level']
      ActiveInTime::Level.new(@active_in_time,@json['level'])
      
    end


    def timetable_id
      @json["timetable_id"]
    end
    
    def name
      @json["name"]
    end
    
    def is_cancelled
      @json["is_cancelled"]
    end
    
    def cancellation_reason
      @json["cancellation_reason"]
    end
    
  end
end
