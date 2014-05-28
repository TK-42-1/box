class Location < ActiveRecord::Base
  has_many :boxes

  validates :code, presence: true, length: {is: 6}
  validates :room, presence: true
  validates :row, presence: true
  validates :section, presence: true
  validates :shelf, presence: true
  validates :slot, presence: true

end
