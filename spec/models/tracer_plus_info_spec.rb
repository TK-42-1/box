require 'spec_helper'

describe TracerPlusInfo do
  describe '#sync_boxes' do
    let(:box) { FactoryGirl.create(:box) }
    let(:first_scan) { FactoryGirl.create(:tracer_plus_info, :stored, box_code: box.id) }
    let(:destroy_scan) { FactoryGirl.create(:tracer_plus_info, :destroyed, box_code: box.id) }
    let(:error_scan) { FactoryGirl.create(:tracer_plus_info, :stored, box_code: 9999) }

    before do
      first_scan
      destroy_scan
      error_scan
      TracerPlusInfo.sync_boxes
      first_scan.reload
      destroy_scan.reload
      error_scan.reload
      box.reload
    end

    context 'first scan' do
      it 'syncs warehouse location code' do
        expect(box.location_code).to eq(first_scan.warehouse_code.to_s)
      end

      it 'marks record as synchronized' do
        expect(first_scan.synchronized).to eq true
      end
    end

    context 'destroy scan' do
      it 'destroyed date' do
        expect(box.destroyed_at).to eq(destroy_scan.destroyed_at)
      end

      it 'marks record as synchronized' do
        expect(destroy_scan.synchronized).to eq true
      end
    end

    context 'error scan' do
      it 'marks record as synchronized and writes error' do
        expect(error_scan.synchronized).to eq true
        expect(error_scan.error).to eq 'Couldn\'t find Box with id=9999'
      end
    end
  end
end
