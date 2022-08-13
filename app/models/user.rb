class User < ApplicationRecord
  has_secure_password
  has_many :groups
  has_many :meetups, through: :groups
  has_many :memberships
  
  validates :name, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, confirmation: { case_sensitive: true }, length: { in: 6..20 }
  
end
