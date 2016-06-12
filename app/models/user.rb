class User < ActiveRecord::Base
  has_many :reviews, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :up_votes, :dependent => :destroy
  has_many :down_votes, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :groups, -> { uniq }, through: :memberships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true


  def favorite_restaurant_ids
    ids = []
    up_votes.each { |v|  ids << v.restaurant.id }
  end

  def veto_restaurant_ids
    ids = []
    down_votes.each { |v|  ids << v.restaurant.id }
  end
  
end
