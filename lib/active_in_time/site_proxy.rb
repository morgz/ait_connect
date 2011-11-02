module ActiveInTime
  class SiteProxy
    def initialize(active_in_time)
      @active_in_time = active_in_time
    end

    def find(id)
      ActiveInTime::Site.new(@active_in_time, @active_in_time.get("sites/#{id}"))
    end

    def nearby(options={})
      raise ArgumentError, "You must include :ll" unless options[:ll]
      
      sites = []
      response = @active_in_time.get('sites', options).each do |site_json|
        sites << ActiveInTime::Site.new(@active_in_time, site_json)
      end
      
      sites
    end

    # def trending(options={})
    #   search_group("trending", options)
    # end
    # 
    # def favorites(options={})
    #   search_group("favorites", options)
    # end
    
    #def nearby(options={})
    #   search_group("nearby", options)
    #end

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
