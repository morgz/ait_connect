module ActiveInTime
  class Base
    API = "http://api.activeintime.com/v1/"
    #API = "http://api.lvh.me:3000/v1/"

    def initialize(*args)
      case args.size
      when 1
        @access_token = args.first
      when 2
        @key, @secret = args
      else
        raise ArgumentError, "You need to pass either an access_token or key and secret"
      end
    end

    # def users
    #   ActiveInTime::UserProxy.new(self)
    # end

    # def checkins
    #   ActiveInTime::CheckinProxy.new(self)
    # end

    def sites
      ActiveInTime::SiteProxy.new(self)
    end
    
    def timetables
      ActiveInTime::TimetableProxy.new(self)
    end

    def timetable_entries
      ActiveInTime::TimetableEntryProxy.new(self)
    end
    
    # def settings
    #   @settings ||= ActiveInTime::Settings.new(self)
    # end

    def get(path, params={})
      params = camelize(params)
      ActiveInTime.log("GET #{API + path}")
      ActiveInTime.log("PARAMS: #{params.inspect}")
      merge_auth_params(params)
      response = JSON.parse(Typhoeus::Request.get(API + path + '.json', :params => params).body)
      ActiveInTime.log(response.inspect)
      error(response) || response["response"]
    end

    def post(path, params={})
      params = camelize(params)
      ActiveInTime.log("POST #{API + path}")
      ActiveInTime.log("PARAMS: #{params.inspect}")
      merge_auth_params(params)
      response = JSON.parse(Typhoeus::Request.post(API + path, :params => params).body)
      ActiveInTime.log(response.inspect)
      error(response) || response["response"]
    end
    
    def authorize_url(redirect_uri)
      # http://developer.foursquare.com/docs/oauth.html
      
      # check params
      raise "you need to define a client id before" if @key.blank?
      raise "no callback url provided" if redirect_uri.blank?
      
      # params
      params = {}
      params["key"] = @key
      params["response_type"] = "code"
      params["redirect_uri"] = redirect_uri
      
      # url
      oauth2_url('authenticate', params)
    end
    
    def access_token(code, redirect_uri)
      # http://developer.foursquare.com/docs/oauth.html
      
      # check params
      raise "you need to define a client id before" if @key.blank?
      raise "you need to define a client secret before" if @secret.blank?
      raise "no code provided" if code.blank?
      raise "no redirect_uri provided" if redirect_uri.blank?
      
      # params
      params = {}
      params["key"] = @key
      params["secret"] = @secret
      params["grant_type"] = "authorization_code"
      params["redirect_uri"] = redirect_uri
      params["code"] = code
      
      # url
      url = oauth2_url('access_token', params)
      
      # response
      # http://developer.foursquare.com/docs/oauth.html
      response = JSON.parse(Typhoeus::Request.get(url).body)
      response["access_token"]
    end

    private
    
    def oauth2_url(method_name, params)
      "https://foursquare.com/oauth2/#{method_name}?#{params.to_query}"
    end

    def camelize(params)
      params.inject({}) { |o, (k, v)|
        o[k.to_s.gsub(/(_[a-z])/) { |m| m[1..1].upcase }] = v
        o
      }
    end

    def error(response)
      case response["meta"]["error"]
      when nil
        # It's all good.
      when "deprecated"
        ActiveInTime.log(ActiveInTime::ERRORS[response['meta']['error']])
        nil
      else
        code = response['meta']['status']
        error = response['meta']['error']['error_message']
        case code
        when 403
          raise ActiveInTime::InvalidAuth.new(error)
        when 501
          raise ActiveInTime::ServiceUnavailable.new(error)
        when 404
          raise ActiveInTime::EndPointMissing.new(error)
        else
          raise ActiveInTime::Error.new(error)
        end
      end
    end

    def merge_auth_params(params)
      if @access_token
        params.merge!(:oauth_token => @access_token)
      else
        params.merge!(:key => @key, :secret => @secret)
      end
    end
  end
end
