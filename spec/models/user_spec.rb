require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(username: "Jason", password: "Pacers4Lyfe") }
  
  
  #validations
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
  
  #associations
  describe "associations" do 
    it { should have_many(:goals) }
  end
  
  describe '#password=' do 
    it "should set an instance variable password" do 
      expect(user.password).to eq("Pacers4Lyfe")
    end 

    
    it "should set the instance variable password_digest" do 
      expect(user.password_digest).to eq(User.last.password_digest)
    end 

  end 

  describe '#is_password?' do 
    it "should return true if password is correct" do 
      expect(user.is_password?(user.password)).to be true
    end 
    
    it "should return false if password is incorrect" do 
      expect(user.is_password?("918723981723981723987")).to be false
    end 
  end 

  describe '#ensure_session_token' do
    it "should set a session token for user" do
      user.session_token = nil 
      user.ensure_session_token 
      expect(user.session_token).not_to be_nil
    end
  end 

  describe "password encryption" do
    it "encrypts password using BCrypt" do
      expect(BCrypt::Password).to receive(:create).with(user.password)
      user = User.new(username: "Ronaldo", password: "Pacers4Lyfe")
    end
  end

  describe "::find_by_credentials" do
    it "find the user if it exists" do
      expect(User.find_by_credentials(user.username, user.password)).to eq(user)
    end

    it "returns nil if user does not exist" do
      expect(User.find_by_credentials("Messi", "ArgentinianGod")).to be_nil
    end
  end

  describe "#reset_session_token!" do
    it "should generate a new session token and return it" do
      prev_session_token = user.session_token
      user.reset_session_token!
      new_session_token = user.session_token
      

      expect(new_session_token).not_to eq(prev_session_token)
      expect(user.reset_session_token!).to eq(user.session_token)
    end

  end
end
