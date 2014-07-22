class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  has_many :boxes
  
  validates :name, presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}

  def self.search(search)
    if search.blank?
      scoped
    else
      where('name LIKE ? or username LIKE ?', "%#{search}%", "%#{search}%")
    end
  end
end
