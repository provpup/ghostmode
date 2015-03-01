require './spec_helper'

RSpec.describe Route do
  
  before :each do
    @route = FactoryGirl.build :route
  end

  describe '#gps_points' do

    it 'should be able to store gps points' do
      gps_point1 = GpsPoint.new(latitude: 49.25, longitude: -123.13333)
      gps_point2 = GpsPoint.new(latitude: 49.5,  longitude: -125.00011)
      @route.gps_points << gps_point1
      @route.gps_points << gps_point2
      @route.save

      expect(@route).to be_valid
      expect(@route.gps_points).to have_exactly(2).items
    end

  end

  describe '.create_checkpoints' do

    it 'should be able to create gps points to be used for checkpoints' do

    end
    
  end
  
end
