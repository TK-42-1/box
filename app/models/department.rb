class Department < ActiveRecord::Base
  has_many :divisions
  has_many :companies, through: :divisions
  
  validates :name, presence: true, length: { maximum: 20 }
end
