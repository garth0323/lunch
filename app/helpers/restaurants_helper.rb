module RestaurantsHelper

  def total_votes restaurant
    restaurant.up_votes.count - restaurant.down_votes.count
  end

end