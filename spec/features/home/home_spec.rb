require 'rails_helper'

describe 'home page' do
  before(:each) do
    visit root_path
  end

  it 'welcomes the user' do
    expect(page).to have_content "Sit at the cool kids table"
  end

  it 'directs to login' do
    click_link 'Get Started'
    expect(page).to have_content "Log in"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
  end
end