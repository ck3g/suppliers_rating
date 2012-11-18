require 'spec_helper'

describe Task do
  it "has a valid factory" do
    create(:task).should be_valid
  end

  describe ".associations" do
    it { should belong_to :supplier_service }
    it { should have_one(:supplier).through(:supplier_service) }
    it { should have_one(:service).through(:supplier_service) }
    it { should have_many :comments }
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

  describe "#close_with_rating!" do
    let!(:task) { create :task }
    it "closes the task" do
      expect {
        task.close_with_rating! 5
      }.to change(task, :status).to("closed")
    end

    it "set rating to 3" do
      expect {
        task.close_with_rating! 3
      }.to change(task, :rating).to(3)
    end
  end

  describe "#reopen!" do
    let!(:closed_task) { create :closed_task }
    it "it reopens the task" do
      expect {
        closed_task.reopen!
      }.to change(closed_task, :status).to("open")
    end
  end
end
