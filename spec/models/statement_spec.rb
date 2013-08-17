# == Schema Information
#
# Table name: statements
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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

  describe "with blank content" do
    before { @statement.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @statement.content = "a" * 1001 }
    it { should_not be_valid }
  end
end
