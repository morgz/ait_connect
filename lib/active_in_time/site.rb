module ActiveInTime
  class Site
    attr_reader :json

    def initialize(active_in_time, json)
      @active_in_time, @json = active_in_time, json
    end
    
    def fetch
      @json = @active_in_time.get("sites/#{id}")
      self
    end

    def id
      @json["id"]
    end
    
    def tldc_approved
      @json['tldc_approved']
    end

    def name
      @json["name"]
    end

    #####
    ##
    ## Contact info
    
    def contact
      @json["contact"]
    end
    
    def post_town
      self.contact['post_town']
    end
    
    def country
      self.contact['country']
    end
    
    def borough
      self.contact['borough']
    end
    
    def address_line_1
      self.contact['address_line_1']
    end
    
    def address_line_2
      self.contact['address_line_2']
    end
    
    def post_code
      self.contact['post_code']
    end

    def latitude
      self.contact['latitude']
    end
    
    def longitude
      self.contact['longitude']
    end
    
    def telephone
      self.contact['telephone']
    end
    
    def email
      self.contact['email']
    end
    
    def website
      self.contact['website']
    end
        
    def timetables
      return [] if @json["timetables"].empty?
      
      timetables = []
      @json['timetables'].each do |timetable|
        timetables << ActiveInTime::Timetable.new(@active_in_time, timetable)
      end
      timetables
      
    end
    
    def facilities
      return [] if @json["facilities"].empty?
      
      facilities = []
      json['facilities'].each do |facility|
        facilities << ActiveInTime::Facility.new(@active_in_time, facility)
      end
      facilities
      
    end
    
    
    #     # not all photos may be present here (but we try to avoid one extra API call)
    #     # if you want to get all the photos, try all_photos
    #     def photos
    #       return all_photos if @json["photos"].blank?
    #       @json["photos"]["groups"].select { |g| g["type"] == "venue" }.first["items"].map do |item|
    #         Foursquare::Photo.new(@foursquare, item)
    #       end
    #     end
    #     
    #     # https://developer.foursquare.com/docs/venues/photos.html
    #     def all_photos(options={:group => "venue"})
    #       @foursquare.get("venues/#{id}/photos", options)["photos"]["items"].map do |item|
    #         Foursquare::Photo.new(@foursquare, item)
    #       end
    #     end
    #     
    #     # count the people who have checked-in at the venue in the last two hours
    #     def here_now_count
    #       fetch unless @json.has_key?("hereNow")
    #       @json["hereNow"]["count"]
    #     end
    #     
    #     # returns a list of checkins (only if a valid oauth token from a user is provided)
    #     # https://developer.foursquare.com/docs/venues/herenow.html
    #     # options: limit, offset, aftertimestamp
    #     def here_now_checkins(options={:limit => "50"})
    #       @foursquare.get("venues/#{id}/herenow", options)["hereNow"]["items"].map do |item|
    #         Foursquare::Checkin.new(@foursquare, item)
    #       end
    #     end
    
  end
end
