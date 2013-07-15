require 'spec_helper'

# ----------------------------------------------------- Spec for Authentication and Authorization

describe "Authentication" do

  subject { page }

# ----------------------------------------------------- Sign in Page
  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign In') }
    it { should have_selector('title', text: 'Sign In') }
  end


  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign In" }

      it { should have_selector('title', text: 'Sign In') }
      it { should have_selector('div.alert-box', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Katmeer" }
        it { should_not have_selector('div.alert-box') }
      end
    end


    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      it { should have_selector('title', text: user.username) }
#      it { should have_link('Account', href: user_path(user)) }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }


      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link('Sign In') }
      end
    end
  end



# ----------------------------------------------------- Edit Pages


  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('p',    text: "Change Your Email") }
      it { should have_selector('title', text: "Update Your Profile") }
    end

    describe "with invalid information" do
      before { click_button "Save Changes" }

      it { should have_content('error') }
    end

# ----------------------------------------------------- Changing Acc. info 

    describe "with valid information" do
      let(:new_username)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Save Changes"
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign Out', href: signout_path) }
      specify { user.reload.email.should == new_email }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_selector('title', text: user.username) }
      it { should have_link('Account',  href: user_path(user)) }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }
    end
  end

# ----------------------------------------------------- Authorization

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Update Your Profile')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Update Your Profile')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end