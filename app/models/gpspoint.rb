# Since GpsPoint can be used both by the Route and Run classes
# we need to make a polymorphic association
class GpsPoint < ActiveRecord::Base
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }

  belongs_to :pointable, polymorphic: true
end
