class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :content, presence: true
end
