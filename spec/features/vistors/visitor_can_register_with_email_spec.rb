require 'rails_helper'

describe "user can register with email" do
  it 'can enter email' do 
    visit root_path

    click_link "Register"

    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[first_name]', with: 'Jim'
    fill_in 'user[last_name]', with: 'Bob'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on('Create Account')
    
    
    expect(page).to have_content "Jim's Dashboard" 
    expect(page).to have_content "This account has not yet been activated. Please check your email."

    open_email('test@example.com')
    current_email.click_link("Visit here to activate your account." )
    expect(page).to have_content "Thank you! Your account is now activated."

    visit dashboard_path

    expect(page).to have_content "Status: Active" 
  end 
end
