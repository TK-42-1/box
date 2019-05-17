require 'spec_helper'

describe Box do
  subject(:box) { FactoryGirl.create(:box) }
  let(:department) { FactoryGirl.create(:department, retain: '3') }
  let(:other_box) { FactoryGirl.create(:box, department: department) }

  it { should be_valid }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:month) }
  it { should validate_presence_of(:year) }

  describe '#destroy_by_list' do
    let!(:box_with_empty_destroy_by) { FactoryGirl.create(:box, :invalid_empty_destroy_by) }

    it 'lists destroy by dates' do
      box
      other_box
      expect(Box.destroy_by_list.sort).to eq([box.destroy_by, other_box.destroy_by.to_s].sort)
    end
  end

  describe '#destroy_by_filter' do
    before do
     box
     other_box
    end

    it 'returns all records' do
      expect(Box.destroy_by_filter('')).to eq Box.all
    end

    it 'filters records by selection' do
      expect(Box.destroy_by_filter(other_box.destroy_by.to_s)).to eq [other_box]
    end
  end

  describe '#destroyed_at_filter' do
    let!(:destroyed) { FactoryGirl.create(:box, destroyed_at: DateTime.now) }
    let!(:not_destroyed_with_invalid_date) { FactoryGirl.create(:box, :invalid_destroyed_at) }

    before do
     box
     other_box
    end

    it 'returns all boxes' do
      expect(Box.destroyed_at_filter('')).to eq Box.all
    end

    it 'returns only destroyed' do
      expect(Box.destroyed_at_filter('destroyed')).to eq [destroyed]
    end

    it 'returns only not destroyed' do
      expect(Box.destroyed_at_filter('not_destroyed').map(&:id).sort).to eq [box, other_box, not_destroyed_with_invalid_date].map(&:id).sort
    end
  end
end
