require 'spec_helper'

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can sign in with right credentials" do
      visit signin_path
      fill_in('username', :with => 'Pekka')
      fill_in('password', :with => 'foobar')
      click_button('Log in')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to sign in form if wrong credentials given" do
      visit signin_path
      fill_in('username', :with => 'Pekka')
      fill_in('password', :with => 'sowrong')
      click_button('Log in')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', :with => 'Brian')
    fill_in('user_password', :with => 'secret')
    fill_in('user_password_confirmation', :with => 'secret')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end