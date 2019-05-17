require 'spec_helper'

describe Box do
  subject(:box) { FactoryGirl.create(:box) }
  
  it { should be_valid }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:month) }
  it { should validate_presence_of(:year) }

  describe '#destroy_by_list' do
    let(:department) { FactoryGirl.create(:department, retain: '3') }
    let(:other_box) { FactoryGirl.create(:box, department: department) }

    it 'lists destroy by dates' do
      box
      other_box
      expect(Box.destroy_by_list).to eq([box.destroy_by, other_box.destroy_by.to_s])
    end
  end
end
