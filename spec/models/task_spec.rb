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
      it { should ensure_inclusion_of(:rating).in_range(1..10) }
    end

    context "when invalid" do
      subject { create :task }
      it { should_not allow_value(nil).for :supplier_service_id }
      it { should_not allow_value(nil).for :title }
      it { should_not allow_value(nil).for :status }
      it { should_not allow_value("unknown-status").for :status }
      it { should_not allow_value(0).for :status }
      it { should_not allow_value(11).for :status }
    end
  end

  describe ".scopes" do
    describe ".closed" do
      let!(:task) { create :task }
      let!(:closed_task) { create :closed_task }
      it "finds only closed tasks" do
        Task.closed.should == [closed_task]
      end
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

    it "set finished_at date" do
      expect {
        task.close_with_rating! 3
      }.to change(task, :finished_at)
    end
  end

  describe "#reopen!" do
    let!(:closed_task) { create :closed_task }
    let!(:closed_task2) { create :closed_task }
    it "it reopens the task" do
      expect {
        closed_task.reopen!
        closed_task.reload
      }.to change(closed_task, :status).to("open")
    end

    it "it resets the finished_at" do
      expect {
        closed_task2.reopen!
        closed_task2.reload
      }.to change(closed_task2, :finished_at).to(nil)
    end

    it "it resets rating" do
      expect {
        closed_task2.reopen!
        closed_task2.reload
      }.to change(closed_task2, :rating).to(nil)
    end
  end

  describe "#pay_to_supplier!" do
    context "when task is not paid" do
      it "changes paid state" do
        task = create :task
        expect {
          task.pay_to_supplier!
          task.reload
        }.to change(task, :paid).to(true)
      end

      it "increase supplier's total amount" do
        task = create :task
        supplier = task.supplier_service.supplier
        expect {
          task.pay_to_supplier!
          supplier.reload
        }.to change(supplier, :total_amount).by(task.cost)
      end

      it "creates new comment" do
        task = create :task
        expect {
          task.pay_to_supplier!
          task.reload
        }.to change(task.comments, :count).by(1)
      end

    end

    context "when cost is blank" do
      let!(:task) { create :costless_task }
      let(:supplier) { task.supplier_service.supplier }
      it "not changes supplier total amount" do
        expect {
          task.pay_to_supplier!
          supplier.reload
        }.to_not change(supplier, :total_amount)
      end

      it "don't create new comment" do
        expect {
          task.pay_to_supplier!
        }.to_not change(Comment, :count).by(1)
      end
    end

    context "when task is paid" do
      let!(:task) { create :paid_task }
      let(:supplier) { task.supplier_service.supplier }
      it "not changes supplier total amount" do
        expect {
          task.pay_to_supplier!
          supplier.reload
        }.to_not change(supplier, :total_amount)
      end

      it "don't create new comment" do
        expect {
          task.pay_to_supplier!
        }.to_not change(Comment, :count).by(1)
      end
    end
  end
end
