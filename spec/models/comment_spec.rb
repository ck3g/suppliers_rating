require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    create(:comment).should be_valid
  end

  describe ".associtiations" do
    it { should belong_to :commentable }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :comment }
      it { should validate_presence_of :message }
      it { should ensure_inclusion_of(:status).in_array(Comment::STATUSES) }
      it { should allow_value("").for :status }
    end
  end
end
