require 'spec_helper'

describe Category do
  it "has a valid factory" do
    create(:category).should be_valid
  end

  describe ".associations" do
    it { should have_many(:services).dependent(:nullify) }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :category }
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of :name }
    end
  end
end
