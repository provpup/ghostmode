require './spec_helper'

RSpec.describe User do

  before :each do
    @user = FactoryGirl.build :user
  end

  describe '#id' do
    it 'should be able to get user id' do
      expect { @user.id }.to_not raise_error
    end
  end

  describe '#username' do
    it 'should be able to get user\'s user name' do
      expect { @user.username }.to_not raise_error
    end

    it 'is required' do
      @user.username = nil
      expect(@user).to_not be_valid
      expect(@user.errors[:username]).to include "can't be blank"
    end

    it 'must be unique' do
      user1 = FactoryGirl.build :user
      user1.username = @user.username
      user1.save

      expect(@user).to_not be_valid
      expect(@user.errors[:username]).to include "has already been taken"
    end
  end

  describe '#password' do
    it 'should return the user\'s password' do
      expect {@user.password}.to_not raise_error
    end

    it 'is required' do 
      @user.password = nil
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include "can't be blank"
    end
  end
end
