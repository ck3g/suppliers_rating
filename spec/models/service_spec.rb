require 'spec_helper'

describe Service do
  it "has a valid factory" do
    create(:service).should be_valid
  end

  describe ".associations" do
    it { should have_many(:supplier_services).dependent(:destroy) }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :service }
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of :name }
    end

    context "when invalid" do
      let!(:service_webdev) { create :service, name: "Web-Development" }
      subject { create :service }
      it { should_not allow_value(nil).for :name }
      it { should_not allow_value("Web-Development").for :name }
    end
  end
end
