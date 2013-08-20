require 'spec_helper'

describe "Statement pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "statement creation" do
    before { visit new_path }

    describe "with invalid information" do

      it "should not create a statement" do
        expect { click_button "Create Discussion" }.not_to change(Statement, :count)
      end

      describe "error messages" do
        before { click_button "Create Discussion" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'statement_content', with: "Lorem ipsum" }
      it "should create a statement" do
        expect { click_button "Create Discussion" }.to change(Statement, :count).by(1)
      end
    end
  end
end