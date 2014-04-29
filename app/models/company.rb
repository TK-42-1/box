class Company < ActiveRecord::Base
  has_many :boxes
  
  validates :name, presence: true
end
