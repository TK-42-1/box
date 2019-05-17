require 'spec_helper'

describe Box do
  subject(:box) { FactoryGirl.create(:box) }
  
  it { should be_valid }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:month) }
  it { should validate_presence_of(:year) }
end
