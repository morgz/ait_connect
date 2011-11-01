require 'spec_helper'


describe ActiveInTime::SiteProxy do

  it "should raise an argument error withouta longitude and latitude param" do
    response = lambda {valid_api_client.sites.nearby(:radius => 20)}.should raise_error(ArgumentError)
  end
  
  it "searching Central London should return a list of sites with valid longitude and latitude" do
    response = valid_api_client.sites.nearby(:ll => "51.5,-0.09", :radius => 20)
    response.is_a?([].class).should == true
    response.size.should > 1
    response.first.is_a?(ActiveInTime::Site).should == true
  end
  
  it "searching for a single site should bring back a single site with matching id" do
    response = valid_api_client.sites.find(1)
    response.is_a?(ActiveInTime::Site).should == true
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