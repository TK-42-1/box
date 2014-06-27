class Department < ActiveRecord::Base
  before_validation :check_indef

  has_many :divisions
  has_many :companies, through: :divisions
  
  validates :name, presence: true, length: { maximum: 20 }
  validates :retain, presence: true

  def check_indef
    if indef == true
      retain = 'INDEF'
      self.retain = retain
    end
  end

  def self.search(search)
    if search.blank?
      scoped
    else
      where('name LIKE ? OR retain LIKE ?', "%#{search}%", "%#{search}%")
    end
  end
end
