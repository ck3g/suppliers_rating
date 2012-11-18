require 'spec_helper'

describe Supplier do
  it "has a valid factory" do
    create(:supplier).should be_valid
  end

  describe ".associations" do
    it { should have_many(:supplier_services).dependent(:destroy) }
    it { should have_many(:tasks).through(:supplier_services) }
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

  describe ".scopes" do
    describe ".term" do
      context "when searching by 'paul'" do
        let!(:bob) { create :supplier, name: "Bob Dylan" }
        let!(:brand) { create :supplier, name: "Paul Brand" }
        let!(:jones) { create :supplier, name: "John Paul Jones"}

        subject { Supplier.term("paul") }
        it { should include brand }
        it { should include jones }
        it { should_not include bob }
      end
    end
  end

  describe "#recalculate_rating!" do
    let(:supplier1) { create :supplier }
    let!(:task1) { create :task, supplier: supplier1, rating: 5 }
    let!(:task2) { create :task, supplier: supplier1, rating: 5 }
    let!(:task3) { create :task, supplier: supplier1, rating: 4 }
    let!(:task4) { create :task, supplier: supplier1, rating: 3 }

    it "recalculates the supplier's rating" do
      expect {
        supplier1.recalculate_rating!
        supplier1.reload
      }.to change(supplier1, :round_rating).to(4.25)
    end

    let(:supplier2) { create :supplier }
    let!(:task5) { create :task, supplier: supplier2, rating: 5 }
    let!(:task6) { create :task, supplier: supplier2, rating: 4 }
    let!(:task7) { create :task, supplier: supplier2, rating: 5 }

    it "recalculates the supplier's rating" do
      expect {
        supplier2.recalculate_rating!
        supplier2.reload
      }.to change(supplier2, :round_rating).to(4.67)
    end
  end
end
