module ActiveInTime
  class TimetableEntryProxy
    def initialize(active_in_time)
      @active_in_time = active_in_time
    end

    def find(id, options = {})
      
      entries = []
      @active_in_time.get("timetables/#{id}/timetable_entries/index", options)['timetable_entries'].each {  |te|
          entries << ActiveInTime::TimetableEntry.new(@active_in_time,te['timetable_entry'])
      }
      entries
      
    end
    
    private

    # def search_group(name, options)
    #       raise ArgumentError, "You must include :ll" unless options[:ll]
    #       response = @foursquare.get('venues/search', options)["groups"].detect { |group| group["type"] == name }
    #       response ? response["items"].map do |json|
    #         Foursquare::Venue.new(@foursquare, json)
    #       end : []
    #     end
  end
end
