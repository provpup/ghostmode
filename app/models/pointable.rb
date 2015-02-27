require_relative 'gpspoint'

module Pointable

  # Instead of just having the has_many clause, we need to override
  # the included method so that when a class includes this module
  # we run the has_many clause in the context of the including class
  def self.included(base)
    base.class_eval do
      has_many :gps_points, as: :pointable
    end
  end
end
