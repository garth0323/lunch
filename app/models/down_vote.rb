class DownVote < Vote
  belongs_to :user
  belongs_to :restaurant
end