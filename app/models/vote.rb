class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :type, presence: true
  validates :type, inclusion: { in: %w(UpVote DownVote) }


end
