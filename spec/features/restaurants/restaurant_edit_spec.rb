require 'rails_helper'

describe :restaurant_edit do
  let(:user) { Fabricate(:user) }
  let!(:restaurant1) { Fabricate(:restaurant) }
  
  describe :edit_restaurant_page, js: true do
    before(:each) do
      login_as(user, :scope => :user)
      visit edit_restaurant_path(restaurant1)
    end
    
    it {expect(page).to have_content "Whats changed?"}
    it {expect(page).to have_content "Name"}
    it {expect(page).to have_content "Description"}

    it :execute_edit do
      fill_in 'Name', with: "Le Grande Orange"
      fill_in 'Description', with: "Is an Orange ever grand?"
      submit_form
      expect(page).to have_selector(".collection-header", text: "Le Grande Orange")
      expect(page).to have_selector(".collection-header", text: "Is an Orange ever grand?")
      expect(page.current_path).to eq restaurant_path(restaurant1)
    end
  end
end