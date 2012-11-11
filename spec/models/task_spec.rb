require 'spec_helper'

describe Task do
  it "has a valid factory" do
    create(:task).should be_valid
  end

  describe ".associations" do
    it { should belong_to :supplier_service }
    it { should have_one(:supplier).through(:supplier_service) }
    it { should have_one(:service).through(:supplier_service) }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :task }
      it { should validate_presence_of :supplier_service_id }
      it { should validate_presence_of :title }
      it { should validate_presence_of :status }
      it { should ensure_inclusion_of(:status).in_array Task::STATUSES }
      it { should allow_value(nil).for(:rating) }
      it { should ensure_inclusion_of(:rating).in_range(1..5) }
    end

    context "when invalid" do
      subject { create :task }
      it { should_not allow_value(nil).for :supplier_service_id }
      it { should_not allow_value(nil).for :title }
      it { should_not allow_value(nil).for :status }
      it { should_not allow_value("unknown-status").for :status }
      it { should_not allow_value(0).for :status }
      it { should_not allow_value(6).for :status }
    end
  end
end
