class Division < ActiveRecord::Base
  belongs_to :company
  belongs_to :department
  
  validates :company_id, presence: true
  validates :department_id, presence: true
end
