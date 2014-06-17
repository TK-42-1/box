class Box < ActiveRecord::Base
  before_validation :create_destroy_by

  belongs_to :user
  belongs_to :company
  belongs_to :department 
  belongs_to :location
  
  validates :description, presence: true, length: {maximum: 45}
  validates :user_id, presence: true
  validates :company_id, presence: true
  validates :department_id, presence: true
  validates :month, presence: true
  validates :year, presence: true
  validates :destroy_by, presence: true

  def create_destroy_by
    dept = Department.find(department_id)
    if dept.retain == 'INDEF'
      destroy_by = 'Indefinite'
      self.destroy_by = destroy_by
    else
      destroy_by = year.to_i + dept.retain.to_i
      self.destroy_by = destroy_by
    end
  end

  def self.search(search)
    if search
      where('description LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.filter(filter)
    if filter
      where('company_id = ?', "#{filter}")
    else
      scoped
    end
  end
end