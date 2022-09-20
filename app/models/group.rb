class Group < ApplicationRecord
  # belongs_to :user
  has_many :users
  has_many :memberships, dependent: :destroy
  has_many :meetups
  
  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
end