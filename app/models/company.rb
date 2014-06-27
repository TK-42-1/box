class Company < ActiveRecord::Base
  has_many :boxes
  has_many :divisions
  has_many :departments, through: :divisions
  
  accepts_nested_attributes_for :divisions
  accepts_nested_attributes_for :departments
  
  validates :name, presence: true, length: { maximum: 20 }
  
  def self.search(search)
    if search.blank?
      scoped
    else
      where('name LIKE ?', "%#{search}%")
    end
  end
end
