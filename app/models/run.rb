require_relative 'pointable'

class Run < ActiveRecord::Base
  include Pointable

  has_many :runs
end