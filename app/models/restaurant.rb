class Restaurant < ActiveRecord::Base
  has_many :reviews, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :up_votes, :dependent => :destroy
  has_many :down_votes, :dependent => :destroy
  has_many :groups

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true


end
