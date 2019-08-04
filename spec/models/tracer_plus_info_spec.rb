require 'spec_helper'

describe TracerPlusInfo do
  describe '#sync_boxes' do
    let(:box) { FactoryGirl.create(:box) }
    let(:first_scan) { FactoryGirl.create(:tracer_plus_info, :stored, box_code: box.id) }

    it 'syncs warehouse location code'do
      expect {
        expect {
          TracerPlusInfo.sync_boxes
          box.reload
          first_scan.reload
        }.to change {
          box.location_code
        }.to(first_scan.warehouse_code.to_s)
      }.to change {
        first_scan.synchronized
      }.to(true)
    end
  end
end
