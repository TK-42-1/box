class Location < ActiveRecord::Base
  
  validates :code, presence: true, length: {is: 5}
  validates :room, presence: true
  validates :row, presence: true
  validates :section, presence: true
  validates :shelf, presence: true
  validates :slot, presence: true
  
end
