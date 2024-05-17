class Walk < ApplicationRecord
  belongs_to :dog
  belongs_to :user
  serialize :path, JSON


  #after_validation :geocoder ,if: :will_save_change_to_path?

  # after_validation :geocode, if: ->(obj){ obj.start_lat.present? and obj.start_lng.present? }
  # #scope :geocoded, do { where.not(start_lat: nil, start_lng: nil, end_lat: nil, end_lng: nil) }

  # def start_coordinates
  #   [start_lat, start_lng]
  # end
  # def end_coordinates
  #   [end_lat, end_lng]
  # end
end
