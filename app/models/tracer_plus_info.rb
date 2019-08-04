class TracerPlusInfo < ActiveRecord::Base
  class << self
    def sync_boxes
      TracerPlusInfo.where(synchronized: false).order(:created_at).each do |tracer|
        box = Box.find(tracer.box_code)
        puts box.inspect
        if box && box.update_attributes(location_code: tracer.warehouse_code)
          tracer.synchronized = true
          tracer.save!
        end
      end
    end
  end
end
