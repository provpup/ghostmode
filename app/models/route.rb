require_relative 'pointable'

class Route < ActiveRecord::Base
  include Pointable

  has_many :runs
end