class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, -> { uniq }, through: :memberships
  belongs_to :restaurant

   scope :time_and_place, -> { where.not(restaurant: nil, appointment: nil) }

  def all_upvoted_no_downvotes
    restaurant_ids = upvoted_by_all - all_downvotes_of_group
    Restaurant.where(id: restaurant_ids)
  end

  def one_upvoted_no_downvotes
    restaurant_ids = all_upvotes_of_group - all_downvotes_of_group
    Restaurant.where(id: restaurant_ids)
  end

  def no_downvotes
    restaurant_ids = all_downvotes_of_group
    Restaurant.where.not(id: restaurant_ids)
  end

  def upvoted_by_all
    result = []
    count = 0
    users.each do |user|
      if count == 0
        result << user.favorite_restaurant_ids
      else
        result && user.favorite_restaurant_ids
      end
      count += 1
    end
    result
  end

  def all_upvotes_of_group
    result = []
    users.each { |user| result << user.favorite_restaurant_ids }
    result.uniq
  end

  def all_downvotes_of_group
    result = []
    users.each { |user| result << user.veto_restaurant_ids }
    result.uniq
  end

end
