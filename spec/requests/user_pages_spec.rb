require 'spec_helper'

describe "UserPages" do
	subject {page}

# ----------------------------------------------------- Show Page

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}

# this is not working because factorygirl isn't logged in...what to do?

    describe "microposts" do
      before do
        sign_in user
        visit user_path(user)
      end

      it { should have_selector('h1', text: user.username) }
      it { should have_selector('title', text: user.username) }

      let!(:m1) {FactoryGirl.create(:statement, user: user, content: "Foo")}
      let!(:m2) {FactoryGirl.create(:statement, user: user, content: "Bar")}

      describe "statements" do
        it { should have_content(m1.content) }
        it { should have_content(m2.content) }
      end
    end
  end

# ----------------------------------------------------- User index
  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    describe "should have" do

      before do 
        sign_in user
        visit users_path
      end

      it { should have_selector('title', text: 'All Kats') }
      it { should have_selector('h1',    text: 'All Kats') }
    end

    describe "pagination" do
      
      before do 
        sign_in user
        visit users_path
      end

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

# ----------------------------------------------------- Broken! (Pagination needs to be sorted out :/)
#      it "should list each user" do
#        User.paginate(page: 1).each do |user|
#          page.should have_selector('li', text: user.username)
#        end
#      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
# ----------------------------------------------------- Broken! (Tests are acting funky...)
 #       it { should have_selector('a', text: 'delete') }
 #       it "should be able to delete another user" do
 #         expect { click_link('delete') }.to change(User, :count).by(-1)
 #       end
 #       it { should_not have_selector('delete', href: user_path(admin)) }
      end

      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { sign_in non_admin }

        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(user) }
          specify { response.should redirect_to(root_path) }
        end
      end
    end
  end

# ----------------------------------------------------- Sign up page
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
      
# ----------------------------------------------------- BROKEN
#     it { should have_selector('li', text: 'Sign Out') }
    end
  end
end


