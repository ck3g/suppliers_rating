require 'spec_helper'

describe Service do
  it "has a valid factory" do
    create(:service).should be_valid
  end

  describe ".associations" do
    it { should have_many(:supplier_services).dependent(:destroy) }
    it { should have_many(:tasks).through(:supplier_services) }
    it { should belong_to :category }
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

  describe ".scopes" do
    describe ".term" do
      context "when searching by 'web'" do
        let!(:web_design) { create :service, name: "Web design" }
        let!(:dev_for_web) { create :service, name: "Development for Web" }
        let!(:ios_dev) { create :service, name: "iOS development"}

        subject { Service.term("web") }
        it { should include web_design }
        it { should include dev_for_web }
        it { should_not include ios_dev }
      end
    end
  end
end
