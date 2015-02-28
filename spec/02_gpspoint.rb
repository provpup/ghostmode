require './spec_helper'

RSpec.describe GpsPoint do

  before :each do
    @point = FactoryGirl.build :gps_point
  end

  describe '#id' do
    it 'should be able to get point id' do
      expect { @point.id }.to_not raise_error
    end
  end

  describe '#longitude' do
    it 'should be to get longitude' do
      expect { @point.longitude }.to_not raise_error
    end

    it 'is required' do
      @point.longitude = nil
      expect(@point).to_not be_valid
      expect(@point.errors[:longitude]).to include "can't be blank"
    end

    it 'should be in the proper range' do
      @point.longitude = -185.03447
      expect(@point).to_not be_valid
      expect(@point.errors[:longitude]).to include "must be greater than or equal to -180.0"

      @point.longitude = 185.03447
      expect(@point).to_not be_valid
      expect(@point.errors[:longitude]).to include "must be less than or equal to 180.0"
    end
  end

  describe '#latitude' do
    it 'should be to get latitude' do
      expect { @point.latitude }.to_not raise_error
    end

    it 'is required' do
      @point.latitude = nil
      expect(@point).to_not be_valid
      expect(@point.errors[:latitude]).to include "can't be blank"
    end

    it 'should be in the proper range' do
      @point.latitude = -95.03447
      expect(@point).to_not be_valid
      expect(@point.errors[:latitude]).to include "must be greater than or equal to -90.0"

      @point.latitude = 95.03447
      expect(@point).to_not be_valid
      expect(@point.errors[:latitude]).to include "must be less than or equal to 90.0"
    end
  end

  
end
