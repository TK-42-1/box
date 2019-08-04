class TracerPlusInfo < ActiveRecord::Base
  class << self
    def sync_boxes
      TracerPlusInfo.where(synchronized: false).order(:created_at).each { |tracer| tracer.sync! }
    end
  end

  def sync!
    box = Box.find(box_code)
    if box && box.update_attributes(location_code: warehouse_code)
      return update_attribute(:synchronized, true)
    end
    false
  end
end
