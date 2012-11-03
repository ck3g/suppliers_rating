require 'spec_helper'

describe Supplier do
  it "has a valid factory" do
    create(:supplier).should be_valid
  end

  describe ".validations" do
    context "when valid" do
      subject { create :supplier }
      it { should validate_presence_of :name }
      it { should validate_presence_of :rank }
      it { should validate_numericality_of(:rank).only_integer }
      it { should allow_value(5).for :rank }
    end

    context "when invalid" do
      subject { create :supplier }
      it { should_not allow_value(nil).for :name }
      it { should_not allow_value(nil).for :rank }
      it { should_not allow_value(-1).for :rank }
      it { should_not allow_value(6).for :rank }
    end
  end
end
