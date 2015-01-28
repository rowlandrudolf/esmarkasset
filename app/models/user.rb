class User < ActiveRecord::Base
  has_secure_password 

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true, email: true 
  
  has_many :articles
  has_many :letters
  has_many :reports 

  after_destroy :ensure_admin

  def full_name
	[ first_name, last_name ].join(' ').titleize 
  end

private 
  
  def ensure_admin
    raise 'Cannot remove this administrative user' unless User.where(admin: true).exists?
  end

end
