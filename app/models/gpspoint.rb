# Since GpsPoint can be used both by the Route and Run classes
# we need to make a polymorphic association
class GpsPoint < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord

  reverse_geocoded_by :latitude, :longitude

  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }

  belongs_to :pointable, polymorphic: true

  def self.closest_point(origin, candidate_point_ids)
    self.where(id: candidate_point_ids).near([origin.latitude, origin.longitude], 20, units: :km).first
  end
end
