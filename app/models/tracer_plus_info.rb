class TracerPlusInfo < ActiveRecord::Base
  class << self
    def sync_boxes
      TracerPlusInfo.where(synchronized: false).order(:created_at).each { |tracer| tracer.sync! }
    end
  end

  def sync!
    box = Box.find(box_code)
    return false unless box.present?

    sync_box(box) && update_attribute(:synchronized, true)
  end

  private

  def sync_box(box)
    if destroyed_at.present?
      handle_destroy(box)
    else
      handle_scan(box)
    end
  end

  def handle_destroy(box)
    box.update_attributes(destroyed_at: destroyed_at)
  end

  def handle_scan(box)
    box.update_attributes(location_code: warehouse_code)
  end
end
