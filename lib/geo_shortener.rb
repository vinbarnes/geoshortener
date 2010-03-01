class GeoShortener
  def self.shorten(location)
    raise(ArgumentError, "Not a valid location") unless valid_decimal_coordinates?(location)
    long, lat = location.split(',')
    compress(long) + compress(lat)
  end
  
  def self.encode_base62(vector)
    # remove decimal
    vector = vector.gsub(".","")
    
    # add zeros for 6 decimal precision
    vector = (vector + "000000")[0..5]
    
    # convert to integers
    vector_int = vector.to_i
    
    # if negative, add 360000000
    if vector_int < 0 then
      vector_int = vector_int + 360000000
    end
    
    # define character_map
    map = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    # convert int to Base62
    
  end
  
  def self.valid_decimal_vector?(vector)
    return false if vector =~ /[a-z]+/i
    return false if !(-180.0..180.0).include?(vector.to_f) 
    return false if vector.split('.')[1].size > 6
    true
  end
  
  def self.valid_decimal_coordinates?(coordinates)
    return false unless coordinates.split(',').size == 2
    return false unless valid_decimal_vector?(coordinates.split(',')[0])
    return valid_decimal_vector?(coordinates.split(',')[1])
  end
end
