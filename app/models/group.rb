class Group < ApplicationRecord
  has_many :users, through: :memberships
  has_many :meetups
  
  validates :title, presence: true
  validates :location, presence: true
end
