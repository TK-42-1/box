require 'spec_helper'

describe Boxes do
  before do
    @user = User.new(name: "Example", username: "example", email: "user@example.com", password: "balls", password_confirmation: "balls")
    @box = Boxes.new( description: 'new box', created_by: @user.username, month: '07', year: '2014', destroy_by: '07-2021')
  end 
  
  subject { @box }
  
  it { should respond_to(:description)}
  it { should respond_to(:created_by)}
  it { should respond_to(:month)}
  it { should respond_to(:year)}
  it { should respond_to(:destroy_by)}
  it { should respond_to(:stored_by)}
  
  it { should be_valid }
  
  describe "when there is no description" do
    before { @box.description = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no creator" do
    before { @box.created_by = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no month" do
    before { @box.month = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no year" do
    before { @box.year = " " }
    it { should_not be_valid }
  end
  
  describe "when there is no destroy date" do
    before { @box.destroy_by = " " }
    it { should_not be_valid }
  end
  
  describe "when destroy date format is bad" do
    it "should be invalid" do
      dates = %w[11/14 072014 A4-FFFF 15/2014 11@2014 12A2014 12+15 ]
      dates.each do |bad_date|
        @box.destroy_by = bad_date
        expect(@box).to_not be_valid
      end
    end
  end
end
