class Walk < ApplicationRecord
  belongs_to :dog
  belongs_to :user
  # serialize :path, JSON
  validates :path, presence: true

  def self.haversine_distance(lat1, lng1, lat2, lng2)
    #calc the distance between two points
    rad_per_deg =Math::PI / 180
    rkm = 6371 # earth radius in km

    dlat_rad = (lat2 - lat1) * rad_per_deg
    dlng_rad = (lng2 - lng1) * rad_per_deg

    lat1_rad, lat2_rad = [lat1, lat2].map { |i| i * rad_per_deg }

    a = Math.sin(dlat_rad / 2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlng_rad / 2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))

    rkm * c # Distance in kilometers
  end
  def set_coords_calc_dist_pace
    return if path.blank?
    puts "Path: #{path.inspect}"
    #set the start coords from the array taken
    self.start_lat, self.start_lng = path.first #when pressing the start track button this then takes that data
    self.end_lat, self.end_lng = path.last   #the last element of the array
    # Debugging output
  puts "Start: #{start_lat}, #{start_lng}"
  puts "End: #{end_lat}, #{end_lng}"
    #calculate the total distance
    self.distance = calculate_total_distance

    # Calculate pace (distance per hour)
    self.pace = calculate_pace if start_time.present? && end_time.present?


  end
  def calculate_total_distance
    total_distance = 0.0
    path.each_cons(2) do |(lat1, lng1), (lat2, lng2)|
      total_distance +=self.class.haversine_distance(lat1, lng1, lat2, lng2)
    end
    return total_distance

  end
  def calculate_pace
    duration_hours = (end_time - start_time) / 3600.0 #duration in hours
    distance / duration_hours if duration_hours > 0
  end

end
