require 'spec_helper'

describe Supplier do
  it "has a valid factory" do
    create(:supplier).should be_valid
  end

  describe ".associations" do
    it { should have_many(:supplier_services).dependent(:destroy) }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :supplier }
      it { should validate_presence_of :name }
      it { should validate_presence_of :rating }
      it { should validate_numericality_of(:rating) }
      it { should allow_value(4.5).for :rating }
    end

    context "when invalid" do
      subject { create :supplier }
      it { should_not allow_value(nil).for :name }
      it { should_not allow_value(nil).for :rating }
      it { should_not allow_value(-1).for :rating }
      it { should_not allow_value(6).for :rating }
    end
  end
end
