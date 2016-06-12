Fabricator(:vote) do
  type %w(UpVote DownVote)
  user :user
  restaurant :restaurant
end