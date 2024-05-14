class Walk < ApplicationRecord
  belongs_to :dog
  after_validation :geocode, if: :will_save_change_to_walks?

  scope :geocoded, -> { where.not(start_lat: nil, start_lng: nil, end_lat: nil, end_lng: nil) }
end
