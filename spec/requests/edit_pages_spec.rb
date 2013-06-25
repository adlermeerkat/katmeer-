require 'spec_helper'

#User Pages and User Authorization (users_controller)

describe "Authorization" do
	subject {page}

  describe "edit email" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(@user, form: "email")}

    describe "page" do
      it { should have_selector('h1',    text: "Change Your Email") }
      it { should have_selector('title', text: "Change Your Email") }
    end

    describe "with invalid information" do
      before { click_button "Save Changes" }

      it { should have_content('error') }
    end
  end
end