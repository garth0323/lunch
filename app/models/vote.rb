class Vote < ActiveRecord::Base
  TYPES = %w(UpVote DownVote)
  
  belongs_to :user
  belongs_to :restaurant

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :type, presence: true
  validates :type, inclusion: { in: TYPES }


end
