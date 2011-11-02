$LOAD_PATH << File.dirname(__FILE__)

require "rubygems"
require "typhoeus"
require "json"
require "cgi"
require "active_in_time/base"
# require "active_in_time/checkin_proxy"
# require "active_in_time/checkin"
# require "active_in_time/user_proxy"
# require "active_in_time/user"
require "active_in_time/site_proxy"
require "active_in_time/site"
require "active_in_time/timetable"
require "active_in_time/timetable_proxy"
require "active_in_time/timetable_entry_proxy"
require "active_in_time/timetable_entry"

require "active_in_time/term_type"
require "active_in_time/timetable_session"
require "active_in_time/instructor"
require "active_in_time/level"
require "active_in_time/timetable_session_category"

require "active_in_time/facility"
require "active_in_time/facility_type"
require "active_in_time/facility_type_category"

# require "active_in_time/settings"
# require "active_in_time/tip"
# require "active_in_time/photo"
# require "active_in_time/location"
# require "active_in_time/category"

module ActiveInTime
  class Error < StandardError ; end
  class InvalidAuth < ActiveInTime::Error; end
  class ServiceUnavailable < ActiveInTime::Error; end
  class EndPointMissing < ActiveInTime::Error; end

  def self.verbose=(setting)
    @verbose = setting
  end

  def self.verbose?
    @verbose
  end

  def self.log(msg)
    return unless verbose?
    puts "[activeintime] #{msg}"
  end

  ERRORS = {
    "invalid_auth" => "OAuth token was not provided or was invalid.",
    "param_error" => "A required parameter was missing or a parameter was malformed. This is also used if the resource ID in the path is incorrect.",
    "endpoint_error" => "The requested path does not exist.",
    "not_authorized" => "Although authentication succeeded, the acting user is not allowed to see this information due to privacy restrictions.",
    "rate_limit_exceeded" => "Rate limit for this hour exceeded.",
    "deprecated" => "Something about this request is using deprecated functionality, or the response format may be about to change.",
    "server_error" => "Server is currently experiencing issues. Check status.activeintime.com for udpates.",
    "other" => "Some other type of error occurred."
  }

end

