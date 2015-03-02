require_relative 'pointable'

class Route < ActiveRecord::Base
  include Pointable

  has_many :runs


  def distance
    # Go through each pair of checkpoints and accumuldate the distance between them
    gps_points.each_cons(2).inject(0.0) do |sum, (segment_start, segment_end)|
      sum + Geocoder::Calculations.distance_between([segment_start.latitude, segment_start.longitude],
                                                    [segment_end.latitude, segment_end.longitude],
                                                     units: :km)
    end
  end
end


