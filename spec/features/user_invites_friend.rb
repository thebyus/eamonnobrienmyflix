require 'spec_helper'

feature 'User invites friend' do
  scenario 'User successfully invites friend and invitation is accepted' do
    adam = Fabricate(:user)
    sign_in(adam)

    invite_a_friend
    friend_accepts_invitation

    friend_should_follow(adam)
    inviter_should_follow_friend(adam)

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "John Smith"
    fill_in "Friend's Email", with: "john@junk.com"
    fill_in "Message", with: "Hello. Please join MyFlix"
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email "john@junk.com"
    current_email.click_link "Accept this Invitation"

    fill_in "Password", with: "password"
    click_button "Sign Up"
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content user.full_name
    sign_out
  end

  def inviter_should_follow_friend(inviter)
    sign_in(invite r)
    click_link "People"
    expect(page).to have_content "John Smith"
  end
end
