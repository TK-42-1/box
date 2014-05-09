class Location < ActiveRecord::Base
  before_validation :create_code

  has_many :boxes

  validates :code, presence: true, length: {is: 5}
  validates :room, presence: true
  validates :row, presence: true
  validates :section, presence: true
  validates :shelf, presence: true
  validates :slot, presence: true

  def create_code
    code = [room, row, section, shelf, slot].join("")
    self.code = code
  end
end
