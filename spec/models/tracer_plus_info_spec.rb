require 'spec_helper'

describe TracerPlusInfo do
  describe '#sync_boxes' do
    let(:box) { FactoryGirl.create(:box) }
    let(:first_scan) { FactoryGirl.create(:tracer_plus_info, :stored, box_code: box.id) }

    before do
      first_scan
      TracerPlusInfo.sync_boxes
      first_scan.reload
      box.reload
    end

    context 'first scan' do

      it 'syncs warehouse location code'do
        expect(box.location_code).to eq(first_scan.warehouse_code.to_s)
      end

      it 'marks record as synchronized' do
        expect(first_scan.synchronized).to eq true
      end
    end
  end
end
