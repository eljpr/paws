class Walk < ApplicationRecord
  belongs_to :dog
  after_validation :geocode, if: :will_save_change_to_walks?
  # geocoded_by :start_coordinates
  # after_validation :geocode, if: ->(obj){ obj.start_lat.present? and obj.start_lng.present? }
  # #scope :geocoded, do { where.not(start_lat: nil, start_lng: nil, end_lat: nil, end_lng: nil) }

  # def start_coordinates
  #   [start_lat, start_lng]
  # end
  # def end_coordinates
  #   [end_lat, end_lng]
  # end
end
