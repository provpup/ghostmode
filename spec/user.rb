require './spec_helper'

describe User do 

  describe '#id' do 
    it 'should be able to get user id'
    expect { @user.id }.to_not raise_error
  end

  describe '#user_name' do 
    it 'should be abe to get user\'s user name'do
      expect { @user.user_name }.to_not raise_error
    end
    it 'is required' do
      @user.user_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors[:user_name]).to include "user name is required"
    end
    it 'must be unique' do 
      user1 = User.new
      user1.name = @user.name
      user1.save

      expect(@user1).to_not be_valid
      expect(@user.errors[:user_name]).to include "user name must be unique"

  describe '#email' do
    it 'should return the user\'s email address' do
      expect {@user.email}.to_not raise_error
    end
    it 'is required' do 
      @user.user_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to include "email is required"
    end
   it 'must be unique' do 
      user1 = User.new
      user1.email = @user.email
      user1.save

      expect(@user1).to_not be_valid
      expect(@user.errors[:email]).to include "email must be unique"
    end



