class User <ActiveRecord::Base
  validates_presence_of :email, :full_name, :password
  validates_uniqueness_of :email

  has_secure_password validations: false
  has_many :queue_items
end