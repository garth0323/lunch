class UpVote < Vote
  belongs_to :user
  belongs_to :restaurant
end