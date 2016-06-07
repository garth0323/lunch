class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :votes
  has_many :up_votes
  has_many :down_votes

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true


end
