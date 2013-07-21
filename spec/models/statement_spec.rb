require 'spec_helper'

describe Statement do

  let(:user) { FactoryGirl.create(:user) }
  before { @statement = user.statements.build(content: "Lorem ipsum") }

  subject { @statement }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @statement.user_id = nil }
    it { should_not be_valid }
  end
end
