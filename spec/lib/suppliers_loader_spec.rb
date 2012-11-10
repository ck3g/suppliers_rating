require 'spec_helper'

describe SuppliersLoader do
  let!(:bob) { create :supplier, name: "Bob" }
  let!(:smith) { create :supplier, name: "Smith" }
  let!(:webdev) { create :service, name: "webdev" }
  let!(:design) { create :service, name: "design" }
  let!(:ss1) { create :supplier_service, supplier: bob, service: webdev }
  let!(:ss2) { create :supplier_service, supplier: bob, service: design }
  let!(:ss3) { create :supplier_service, supplier: smith, service: webdev }

  describe ".list" do
    before { @suppliers = SuppliersLoader.list }
    it "loads suppliers list ordered by name" do
      @suppliers.should == [bob, smith]
    end

    it "first has 2 services" do
      @suppliers.first.services_count.should == "2"
    end

    it "last has 1 service" do
      @suppliers.last.services_count.should == "1"
    end
  end
end
