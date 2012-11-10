require 'spec_helper'

describe ServicesLoader do
  let!(:bob) { create :supplier, name: "Bob" }
  let!(:smith) { create :supplier, name: "Smith" }
  let!(:webdev) { create :service, name: "webdev" }
  let!(:design) { create :service, name: "design" }
  let!(:ss1) { create :supplier_service, supplier: bob, service: webdev }
  let!(:ss2) { create :supplier_service, supplier: bob, service: design }
  let!(:ss3) { create :supplier_service, supplier: smith, service: webdev }

  describe ".list" do
    before { @services = ServicesLoader.list }
    it "loads suppliers list ordered by name" do
      @services.should == [design, webdev]
    end

    it "first has 1 supplier" do
      @services.first.suppliers_count.should == "1"
    end

    it "last has 2 supplier" do
      @services.last.suppliers_count.should == "2"
    end
  end
end
