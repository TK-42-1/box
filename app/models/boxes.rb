class Boxes < ActiveRecord::Base
  
  VALID_DESTORY_DATE_REGEX = /\d{2}-\d{4}/
  
  validates :description, presence: true
  validates :created_by, presence: true
  validates :month, presence: true
  validates :year, presence: true
  validates :destroy_by, presence: true, format: { with: VALID_DESTORY_DATE_REGEX }
end
