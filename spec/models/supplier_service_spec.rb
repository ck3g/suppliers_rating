require 'spec_helper'

describe SupplierService do
  it "has a valid factory" do
    create(:supplier_service).should be_valid
  end

  describe ".associtiations" do
    it { should belong_to :supplier }
    it { should belong_to :service }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :supplier_service }
      it { should validate_presence_of :supplier_id }
      it { should validate_presence_of :service_id }
      it { should validate_presence_of :price }
      it { should validate_numericality_of :price }
      it { should allow_value(0).for :price }
    end

    context "when invalid" do
      subject { create :supplier_service }
      it { should_not allow_value(nil).for :supplier_id }
      it { should_not allow_value(nil).for :service_id }
      it { should_not allow_value(nil).for :price }
      it { should_not allow_value("string").for :price }
      it { should_not allow_value(-1).for :price }
    end
  end
end
