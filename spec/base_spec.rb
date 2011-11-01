require 'spec_helper'


describe ActiveInTime::Base do

  it "should not pass through sites without a valid API key testing sites" do
    response = lambda {invalid_api_client.sites.nearby(:ll => "51.5,-0.09", :radius => 20)}.should raise_error(ActiveInTime::InvalidAuth)
  end
  
  it "should not pass through timetables without a valid API key testing sites" do
    response = lambda {invalid_api_client.timetables.find(1)}.should raise_error(ActiveInTime::InvalidAuth)
  end
  
  it "should not pass through timetable_entries without a valid API key testing sites" do
    response = lambda {invalid_api_client.timetable_entries.find(1)}.should raise_error(ActiveInTime::InvalidAuth)
  end
  
end