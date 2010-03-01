$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'geo_shortener'
# require 'bacon'

describe GeoShortener, '.shorten' do
  it 'should accept a location argument' do
    lambda { GeoShortener.shorten('34.004147,-84.313717') }.should.not.raise(ArgumentError)
  end
  
  it 'should complain if no argument provided' do
    lambda { GeoShortener.shorten() }.should.raise(ArgumentError)
  end
  
  it 'should not accept a non-location argument' do
    lambda { GeoShortener.shorten('larry') }.should.raise(ArgumentError)
  end
  
  it 'should return a shortened base62 coordinate when valid location provided' do
    GeoShortener.shorten('34.004147,-84.313717').should == '2iG1ZiEKAX'
  end
end

describe GeoShortener, '.valid_decimal_vector?' do
  it 'should return false if not a number' do
    GeoShortener.valid_decimal_vector?('asdf').should == false
  end
  
  it 'should return false if greater than 180' do
    GeoShortener.valid_decimal_vector?('185').should == false
  end
  
  it 'should return false if less than -180' do
    GeoShortener.valid_decimal_vector?('-185').should == false
  end
  
  it 'should return true if it is a number between -180 and 180' do
    GeoShortener.valid_decimal_vector?('0.0').should == true
  end
  
  it 'should return false if precision is > 6' do
    GeoShortener.valid_decimal_vector?('0.0000001').should == false
  end
  
  it 'should return true if precision is <= 6' do
    GeoShortener.valid_decimal_vector?('0.000001').should == true
  end
end

describe GeoShortener, '.valid_decimal_coordinates?' do
  it 'should return false if no comma is used to separate decimal vectors' do
    GeoShortener.valid_decimal_coordinates?('0.1 0.1').should == false
  end

  it 'should return false if more than two decimal vectors are provided' do
    GeoShortener.valid_decimal_coordinates?('0.1,0.1,0.1').should == false
  end
  
  it 'should return false if less than two decimal vectors provided' do
    GeoShortener.valid_decimal_coordinates?('0.1').should == false
  end
  
  it 'should return false if longitude decimal vector is invalid' do
    GeoShortener.valid_decimal_coordinates?('-180.1,0.1').should == false
  end

  it 'should return false if latitude decimal vector is invalid' do
    GeoShortener.valid_decimal_coordinates?('0.1,-180.1').should == false
  end

  it 'should return false if both decimal vectors are invalid' do
    GeoShortener.valid_decimal_coordinates?('-180.1,-180.1').should == false
  end

  it 'should return true if both decimal vectors are valid' do
    GeoShortener.valid_decimal_coordinates?('0.1,0.1').should == true
  end
end

# GeoShortener.shorten('36.123, -17.123') # => 'asdf890'
# GeoShortener.expand('asdf890') # => '36.123, -17.123'
# 
# url = GeoUrl.new('36.123, -17.123')
# url.latitude
