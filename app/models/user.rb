class User < ActiveRecord::Base
  has_many :reviews
  has_many :votes
  has_many :up_votes
  has_many :down_votes
  has_many :memberships
  has_many :groups, through: :memberships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  
end
