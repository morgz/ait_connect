require 'spec_helper'


describe ActiveInTime::TimetableProxy do

  it "searching for a single site should bring back timetables in the json" do
    response = valid_api_client.sites.find(1)
    response.timetables.is_a?([].class).should == true
    response.timetables.size > 0
    response.timetables.first.is_a?(ActiveInTime::Timetable).should == true
  end
  
  it "searching for a single timetable should bring back a single timetables" do
    response = valid_api_client.timetables.find(1)
    response.is_a?(ActiveInTime::Timetable).should == true
    response.id.should == 1
  end
  
  it "searching with pagination (1 per page) should bring back 1 result only" do
    response = valid_api_client.sites.nearby(:ll => "51.5,-0.09", :radius => 20, :per_page => 1)
    response.is_a?([].class).should == true
    response.size.should == 1
    response.first.is_a?(ActiveInTime::Site).should == true
  end
  
  it "searching with pagination (1 per page) should bring back 2 different results on 2 pages" do
    response = valid_api_client.sites.nearby(:ll => "51.5,-0.09", :radius => 20, :per_page => 1, :page => 1)
    first_site = response.first
    
    response = valid_api_client.sites.nearby(:ll => "51.5,-0.09", :radius => 20, :per_page => 1, :page => 2)
    second_site = response.first
    
    first_site.should_not == second_site
    
  end
  
  
  
  
  
end