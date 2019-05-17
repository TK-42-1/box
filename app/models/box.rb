class Box < ActiveRecord::Base
  before_validation :create_destroy_by

  belongs_to :user
  belongs_to :company
  belongs_to :department
  belongs_to :location, foreign_key: :code, primary_key: :id

  validates :description, presence: true, length: {maximum: 45}
  validates :user, presence: true
  validates :company, presence: true
  validates :department, presence: true
  validates :month, presence: true
  validates :year, presence: true
  validates :destroy_by, presence: true

  def create_destroy_by
    return false unless department
    if department.retain == 'INDEF'
      destroy_by = 'Indefinite'
      self.destroy_by = destroy_by
    else
      destroy_by = year.to_i + department.retain.to_i
      self.destroy_by = destroy_by
    end
  end

  def self.search(search)
    if search.blank?
      Box.all
    else
      where('description LIKE ?', "%#{search}%")
    end
  end

  def self.filter(filter)
    if filter.blank?
      Box.all
    else
      where('company_id = ?', "#{filter}")
    end
  end

  def self.deptfilter(deptfilter)
    if deptfilter.blank?
      all
    else
      where('department_id = ?', "#{deptfilter}")
    end
  end

  def self.destroy_by_list
    select('destroy_by').distinct.map(&:destroy_by).sort.delete_if { |d| d == '' }
  end

  def self.destroy_by_filter(filter)
    return  Box.all if filter.blank?
    where(destroy_by: filter)
  end

  def self.destroyed_at_filter(filter)
    return where('destroyed_at IS NOT NULL AND destroyed_at != 0') if filter == 'destroyed'
    return where('destroyed_at IS NULL OR destroyed_at = 0') if filter == 'not_destroyed'
    all
  end
end
