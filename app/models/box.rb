class Box < ActiveRecord::Base
    
  belongs_to :user
  belongs_to :company
  belongs_to :department 
  belongs_to :location
  
  validates :description, presence: true
  validates :user_id, presence: true
  validates :company_id, presence: true
  validates :department_id, presence: true
  validates :month, presence: true
  validates :year, presence: true
  validates :destroy_by, presence: true
  
end