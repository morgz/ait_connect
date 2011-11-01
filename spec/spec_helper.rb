require 'rubygems'
require 'bundler/setup'

require 'ait_connect' # and any other gems you need

RSpec.configure do |config|
  # some (optional) config here
  
  def invalid_api_client
    ActiveInTime::Base.new("bollocks key","pizza is goood")
  end
  
  def valid_api_client
    ActiveInTime::Base.new("EvVqRnFW4R53IUvcjP4uPjXzaQxNhNMCMZ2G5j5l","iE8iBM7tVXGlqF179qdr7UWhyPFIBROQ2tjtmE8M")
  end
  
end