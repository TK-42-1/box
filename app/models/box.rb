class Box < ActiveRecord::Base
  
  VALID_DESTORY_DATE_REGEX = /\d{2}-\d{4}/
  
  belongs_to :user
  belongs_to :company
  belongs_to :department 
  
  validates :description, presence: true
  validates :user_id, presence: true
  validates :company_id, presence: true
  validates :department_id, presence: true
  validates :month, presence: true
  validates :year, presence: true
  validates :destroy_by, presence: true, format: { with: VALID_DESTORY_DATE_REGEX }
end
