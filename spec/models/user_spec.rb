require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example", email: "user@example.com", password: "balls", password_confirmation: "balls")}
  
  subject { @user }
  
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should be_valid }
  
  describe "when there is no name" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when the name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when there is no email" do
    before {@user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is bad" do
    it "should not be valid" do
      addresses = %w[satan@hell,com satan_at_hell.com morning.star@hell. satan@7th_level.com satan@7th+level.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
  
  describe "when email format is good" do
    it "should be valid" do
      addresses = %w[satan@hell.COM SATAN@hell.com morning.star@hell.info mister.satan@7thlevel.com mr+satan@7th-level.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  
  describe "when email is taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
  
  describe "when there is no password" do
    before do 
      @user = User.new(name: "Example", email: "user@example.com", password: "", password_confirmation: "")
    end
    it { should_not be_valid }
  end
  
  describe "when password/confirmation dont match" do
    before do
      @user = User.new(name: "Example", email: "user@example.com", password: "balls", password_confirmation: "butts")
    end
    it { should_not be_valid }
  end
  
  describe "with a password thats too short" do
    before { @user.password = @user.password_confirmation = "a" * 4 }
    
    it { should be_invalid }
  end
  
  describe "return value of auth method" do
    before { @user.save }
    let(:found_user) {User.find_by(email:@user.email)}
    
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password)}
    end
    
    describe "with invalid password" do
      let (:user_bad) {found_user.authenticate("invalid")}
      
      it { should_not eq user_bad }
      specify { expect(user_bad).to be_false }
    end
  end
end
