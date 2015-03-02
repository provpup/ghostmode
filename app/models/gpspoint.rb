# Since GpsPoint can be used both by the Route and Run classes
# we need to make a polymorphic association
class GpsPoint < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord

  reverse_geocoded_by :latitude, :longitude

  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }

  belongs_to :pointable, polymorphic: true

  def self.closest_point(origin, previous_gps_time_source = nil, candidate_points)
    point_ids = candidate_points.to_a.map { |point| point.id }
    if previous_gps_time_source
      selection = self.where(id: point_ids).where("gps_timestamp >= ?", previous_gps_time_source.gps_timestamp)
    else
      selection = self.where(id: point_ids)
    end
    selection.near([origin.latitude, origin.longitude], 10, units: :km).limit(1).first
  end
end
