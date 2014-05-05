class Department < ActiveRecord::Base
  has_many :divisions
  has_many :companies, through: :divisions
end
