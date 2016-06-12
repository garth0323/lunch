require 'rails_helper'

describe :restaurants do
  let(:user) { Fabricate(:user) }
  let!(:restaurant1) { Fabricate(:restaurant) }
  let!(:restaurant2) { Fabricate(:restaurant) }
  
  context :unauthorized do
    it 'redirects to login page' do
      visit restaurants_path

      expect(page.current_path).to eq new_user_session_path
    end
  end
  
  context :authorized do
    describe :index do
      before(:each) do
        login_as(user, :scope => :user)
        visit restaurants_path
      end
      
      it {expect(page).to have_content "Restaurants"}
      it {expect(page).to have_content restaurant1.name}
      it {expect(page).to have_content restaurant1.description}
      it {expect(page).to have_content restaurant2.name}
      it {expect(page).to have_content restaurant2.description}
    end

    describe :new_restaurant do
      before(:each) do
        login_as(user, :scope => :user)
      end

      it :new_restaurant_page do
        visit restaurants_path
        click_link 'add'
        expect(page.current_path).to eq new_restaurant_path
      end

      it :create_a_restaurant, js: true do
        visit new_restaurant_path
        fill_in "Name", with: "Chelsea's Kitchen"
        fill_in "Description", with: "It is delicious"
        submit_form

        expect(page).to have_content "Reviews"
        expect(page).to have_content "Chelsea's Kitchen"
        expect(page).to have_content "It is delicious"
        expect(page).to have_content "Be the first to write a review!"
      end
    end  
  end
end