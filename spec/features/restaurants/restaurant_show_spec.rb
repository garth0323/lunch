require 'rails_helper'

describe :restaurant_show do
  let(:user) { Fabricate(:user) }
  let!(:restaurant1) { Fabricate(:restaurant) }
  
  describe :show_restaurant do
    before(:each) do
      login_as(user, :scope => :user)
      visit restaurant_path(restaurant1)
    end
    
    it {expect(page).to have_content "Reviews"}
    it {expect(page).to have_content restaurant1.name}
    it {expect(page).to have_content restaurant1.description}
    it {expect(page).to have_content "Rating"}
    it {expect(page).to have_content "Change Details of Restaurant"}
  end

  describe :navigates_to_edit do
    before(:each) do
      login_as(user, :scope => :user)
      visit restaurant_path(restaurant1)
      click_link "Change Details of Restaurant"
    end
    
    it {expect(page.current_path).to eq edit_restaurant_path(restaurant1)}
  end

  describe :review_restaurant, js: true do
    before(:each) do
      login_as(user, :scope => :user)
      visit restaurant_path(restaurant1)
    end

    it :new_review do
      find('#review_content').set("It's Delicious")
      submit_form
      expect(page).to have_content restaurant1.name
      expect(page).to have_css(".reviews", text: "It's Delicious")
      expect(page).to have_css(".reviews", text: user.username)
      expect(page).to have_css(".reviews", text: "less than a minute ago")
    end
  end

  describe :vote_restaurant, js: true do
    before(:each) do
      login_as(user, :scope => :user)
      visit restaurant_path(restaurant1)
    end

    it :new_upvote do
      click_link 'thumb_up'
      expect(page).to have_content restaurant1.name
      expect(page).to have_css(".total-votes", text: "Rating: 1")
    end

    it :new_downvote do
      click_link 'thumb_down'
      expect(page).to have_content restaurant1.name
      expect(page).to have_css(".total-votes", text: "Rating: -1")
    end

    context 'when down vote exists for user' do
      let!(:vote) { Fabricate(:vote, type: 'DownVote', user: user, restaurant: restaurant1) }
      it :down_vote do
        click_link 'thumb_down'
        expect(page).to have_content restaurant1.name
        expect(page).to have_content "You can only down vote once!"
      end

      it :up_vote do
        click_link 'thumb_up'
        expect(page).to have_content restaurant1.name
        expect(page).to have_css(".total-votes", text: "Rating: 1")
      end
    end

    context 'when up vote exists for user' do
      let!(:vote) { Fabricate(:vote, type: 'UpVote', user: user, restaurant: restaurant1) }
      it :up_vote do
        click_link 'thumb_up'
        expect(page).to have_content restaurant1.name
        expect(page).to have_content "You can only up vote once!"
      end

      it :down_vote do
        click_link 'thumb_down'
        expect(page).to have_content restaurant1.name
        expect(page).to have_css(".total-votes", text: "Rating: -1")
      end
    end
  end  

end