include ApplicationHelper

def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

{ have_error_message:   'div.alert.alert-error',
  have_success_message: 'div.alert.alert-success',
  have_h1:              'h1',
  have_title:           'title' }.each do |helper, attribute|
  Rspec::Matchers.define helper do |message|
    match do |page|
      page.should have_selector(attribute, text: message)
    end
  end
end
