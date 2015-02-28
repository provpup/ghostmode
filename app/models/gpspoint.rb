# Since GpsPoint can be used both by the Route and Run classes
# we need to make a polymorphic association
class GpsPoint < ActiveRecord::Base
  belongs_to :pointable, polymorphic: true
end
