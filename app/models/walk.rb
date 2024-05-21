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
  def set_coords

  end
end
