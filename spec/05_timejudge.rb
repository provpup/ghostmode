require './spec_helper'

RSpec.describe TimeJudge do

  before :all do
    @user = FactoryGirl.create :user
    @route = FactoryGirl.create :route
    @route.gps_points << GpsPoint.new(latitude: 49.50000000, longitude: -123.13333)
    @route.gps_points << GpsPoint.new(latitude: 49.50000005, longitude: -123.13333)
    @route.gps_points << GpsPoint.new(latitude: 49.50000010, longitude: -123.13333)
    @route.gps_points << GpsPoint.new(latitude: 49.50000015, longitude: -123.13333)
    @route.gps_points << GpsPoint.new(latitude: 49.50000020, longitude: -123.13333)
    @route.gps_points << GpsPoint.new(latitude: 49.50000025, longitude: -123.13333)
    @route.gps_points << GpsPoint.new(latitude: 49.50000030, longitude: -123.13333)
    @route.gps_points << GpsPoint.new(latitude: 49.50000035, longitude: -123.13333)
    @route.save
  end

  describe '.split_times' do

    it 'should produce accurate split times' do
      run1 = Run.create(user_id: @user.id, route_id: @route.id)

      run1_start_time = Time.now
      run1.gps_points << GpsPoint.new(latitude: 49.50000000, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time)
      run1.gps_points << GpsPoint.new(latitude: 49.50000005, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 30)
      run1.gps_points << GpsPoint.new(latitude: 49.50000010, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 20)
      run1.gps_points << GpsPoint.new(latitude: 49.50000015, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 40)
      run1.gps_points << GpsPoint.new(latitude: 49.50000020, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 30)
      run1.gps_points << GpsPoint.new(latitude: 49.50000025, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 25)
      run1.gps_points << GpsPoint.new(latitude: 49.50000030, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 35)
      run1.gps_points << GpsPoint.new(latitude: 49.50000035, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 30)
      run1.save

      run2 = Run.create(user_id: @user.id, route_id: @route.id)
      run2_start_time = Time.now
      run2.gps_points << GpsPoint.new(latitude: 49.50000000, longitude: -123.13333001,
                                      gps_timestamp: run2_start_time)
      run2.gps_points << GpsPoint.new(latitude: 49.50000005, longitude: -123.13333001,
                                      gps_timestamp: run2_start_time += 30)
      run2.gps_points << GpsPoint.new(latitude: 49.50000010, longitude: -123.13333001,
                                      gps_timestamp: run2_start_time += 40)
      run2.gps_points << GpsPoint.new(latitude: 49.50000015, longitude: -123.13333001,
                                      gps_timestamp: run2_start_time += 20)
      run2.gps_points << GpsPoint.new(latitude: 49.50000020, longitude: -123.13333001,
                                      gps_timestamp: run2_start_time += 30)
      run2.gps_points << GpsPoint.new(latitude: 49.50000025, longitude: -123.13333001,
                                      gps_timestamp: run2_start_time += 35)
      run2.gps_points << GpsPoint.new(latitude: 49.50000030, longitude: -123.13333001,
                                      gps_timestamp: run2_start_time += 25)
      run2.gps_points << GpsPoint.new(latitude: 49.50000035, longitude: -123.13333001,
                                      gps_timestamp: run2_start_time += 30)
      run2.save

      split_results = TimeJudge.split_times(run1, run2)
      expect(split_results.values).to eq([0.0, 20.0, -20.0, 0.0, 10.0, -10.0, 0.0])
    end
  end

  describe '.run_checkpoint_times' do

    it 'should produce accurate relative run times' do
      run1 = Run.create(user_id: @user.id, route_id: @route.id)

      run1_start_time = Time.now
      run1.gps_points << GpsPoint.new(latitude: 49.50000000, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time)
      run1.gps_points << GpsPoint.new(latitude: 49.50000005, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 30)
      run1.gps_points << GpsPoint.new(latitude: 49.50000010, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 20)
      run1.gps_points << GpsPoint.new(latitude: 49.50000015, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 40)
      run1.gps_points << GpsPoint.new(latitude: 49.50000020, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 30)
      run1.gps_points << GpsPoint.new(latitude: 49.50000025, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 25)
      run1.gps_points << GpsPoint.new(latitude: 49.50000030, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 35)
      run1.gps_points << GpsPoint.new(latitude: 49.50000035, longitude: -123.13332999,
                                      gps_timestamp: run1_start_time += 30)
      run1.save

      relative_times = TimeJudge.run_checkpoint_times(run1)
      expect(relative_times.values).to eq([30.0, 20.0, 40.0, 30.0, 25.0, 35.0, 30.0])
    end
  end

end