class Location < ActiveRecord::Base
  has_many :boxes, foreign_key: :location_code, primary_key: :id

  validates :code, presence: true
  validates :room, presence: true
  validates :row, presence: true
  validates :section, presence: true
  validates :shelf, presence: true
  validates :slot, presence: true
  
  def self.search(search)
    if search.blank?
      scoped
    else
      where('code LIKE ?', "%#{search}%")
    end
  end
end 
