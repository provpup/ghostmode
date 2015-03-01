require './spec_helper'

RSpec.describe Run do
  
  before :each do
    @user = FactoryGirl.build :user
    @route = FactoryGirl.build :route
  end

  describe '#gps_points' do

    it 'should be able to store gps points' do
      @user.save
      @route.save

      gps_point1 = GpsPoint.new(latitude: 49.25, longitude: -123.13333)
      gps_point2 = GpsPoint.new(latitude: 49.5,  longitude: -125.00011)
      gps_point3 = GpsPoint.new(latitude: 50.1,  longitude: -120.40162)

      run = Run.new(user_id: @user.id, route_id: @route.id)
      run.gps_points << gps_point1
      run.gps_points << gps_point2
      run.gps_points << gps_point3
      run.save

      expect(run).to be_valid
      expect(run.gps_points).to have_exactly(3).items
    end
  end
  
end
