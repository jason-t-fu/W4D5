require 'rails_helper'
require 'spec_helper'

feature 'the signup process' do
  background(:each) do
    User.create!(username: "Pacers", password: "LostOladipo")
  end

  scenario 'has a new user page' do 
    visit new_user_url
    expect(page).to have_content("Sign Up")  
  end
  
  feature 'signing up a user' do
    background(:each) do
      visit new_user_url
      fill_in 'username', with: 'Sixers'
      fill_in 'password', with: 'SuckNuts'
    end

    scenario 'shows username on the homepage after signup' do 
      visit users_url
      expect(page).to have_content('Pacers')
    end 

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do 
    visit users_url
    expect(page).to have_content('Pacers')
  end 

end

feature 'logging out' do
  scenario 'begins with a logged out state' do 
    visit users_url
    expect(page).to have_content('Log In')
  end

  scenario 'doesn\'t show username on the homepage after logout' do 
    visit users_url
    expect(page).not_to have_content('Pacers')
  end 

end
