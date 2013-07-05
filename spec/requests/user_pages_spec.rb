require 'spec_helper'

describe "UserPages" do
	subject {page}

	describe "Sign Up Page" do
		before {visit signup_path}

		it {should have_selector('h1', text: "Sign Up")}
		it {should have_selector('title', text: full_title('Sign Up'))}
	end

  describe "Sign Up Forms" do

    before { visit signup_path }

    let(:submit) { "Sign Up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username",     with: "Example"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
#BROKEN
      it { should have_slector('li', text: 'Sign Out') }
    end
  end


# Users Show page

  describe "User Show Page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it {should have_selector('h1', text: user.username)}
    it {should have_selector('title', text: full_title(user.username))}
    
  end



#Users Edit Page
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1',    text: "Change Your Email") }
      it { should have_selector('h1',    text: "Change Your Password") }
      it { should have_selector('title', text: "Update Your Profile") }
    end

    describe "with invalid information" do
      before { click_button "Change Email" }

      it { should have_content('error') }
    end
  end
end


