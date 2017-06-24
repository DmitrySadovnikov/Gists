#### example ####
# password_reset_spec.rb
require 'spec_helper'

describe 'PasswordReset' do
  it 'emails user when requesting password reset' do
    user = Factory(:user)
    visit login_path
    click_link 'password'
    fill_in 'email', with: user.email
    click_button 'ResetPassword'
    current_path.should eq(root_path)
    page.should have_content('Email sent') # it is flash message
    last_email
  end

  it 'does not email invalid user when requesting password reset' do
    visit login_path
    click_link 'password'
    fill_in 'email', with: 'nobody@example.com'
    click_button 'ResetPassword'
    current_path.should eq(root_path)
    page.should have_content('Email sent') # it is flash message
    last_email.should be_nil
  end
end

# factories
Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password 'secret'
end

# mailer helper
module MailerMacros
  def last_email
    ActiveMailer::Base.deliver.last
  end

  def reset_email
    ActiveMailer::Base.deliver = []
  end
end

# spec_helper.rb
config.include(MailerMacros)
config.before(:each) { reset_email }


####################

