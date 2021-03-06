require 'spec_helper'

describe SuppliersController do
  let!(:supplier_bob) { create :supplier, name: "Bob", rating: 5 }
  let!(:supplier_smith) { create :supplier, name: "Smith", rating: 4 }

  describe "user signed in" do
    login_user
    let(:user) { subject.current_user }
    it_behaves_like "user is signed in"

    describe "GET #index" do
      before { get :index }

      it { should assign_to(:suppliers).with [supplier_bob, supplier_smith] }
      it { should respond_with :success }
      it { should render_template :index }
      it { should_not set_the_flash }

      context "when searching by 'bob'" do
        before { get :index, term: "bob" }
        it { should assign_to(:suppliers).with [supplier_bob] }
      end
    end

    describe "GET #new" do
      before { get :new }
      it { should assign_to(:supplier).with_kind_of Supplier }
      it { should respond_with :success }
      it { should render_template :new }
      it { should_not set_the_flash }
    end

    describe "POST #create" do
      context "with valid params" do
        before do
          post :create, supplier: attributes_for(:supplier)
        end
        it { should assign_to(:supplier).with_kind_of Supplier }
        it { should redirect_to suppliers_path }
        it { should set_the_flash[:notice].to I18n.t(:successfully_created) }
        it "creates new supplier" do
          expect {
            post :create, supplier: attributes_for(:supplier)
          }.to change(Supplier, :count).by(1)
        end
      end

      context "with invalid params" do
        before do
          post :create, supplier: attributes_for(:invalid_supplier)
        end
        it { should render_template :new }
        it "not creates new supplier" do
          expect {
            post :create, supplier: attributes_for(:invalid_supplier)
          }.to_not change(Supplier, :count).by(1)
        end
      end
    end

    describe "GET #show" do
      before { get :show, id: supplier_bob.id }
      it { should assign_to(:supplier).with supplier_bob }
      it { should respond_with :success }
      it { should_not set_the_flash }
      it { should render_template :show }
    end

    describe "GET #tasks" do
      before { get :tasks, id: supplier_bob.id }
      it { should assign_to(:supplier).with supplier_bob }
      it { should respond_with :success }
      it { should_not set_the_flash }
      it { should render_template :tasks }
    end

    describe "GET #info" do
      before { get :info, id: supplier_bob.id }
      it { should assign_to(:supplier).with supplier_bob }
      it { should respond_with :success }
      it { should_not set_the_flash }
      it { should render_template :info }
    end

    describe "GET #edit" do
      before { get :edit, id: supplier_bob.id }
      it { should assign_to(:supplier).with supplier_bob }
      it { should respond_with :success }
      it { should render_template :edit }
      it { should_not set_the_flash }
    end

    describe "PUT #update" do
      context "with valid params" do
        before do
          put :update, id: supplier_bob, supplier: attributes_for(:supplier)
        end
        it { should assign_to(:supplier).with supplier_bob }
        it { should redirect_to supplier_bob }
        it { should set_the_flash[:notice].to I18n.t(:successfully_updated) }
        it "changes supplier_bob's attributes" do
          expect {
            put :update, id: supplier_bob, supplier: attributes_for(:supplier, name: "Frank Zappa")
            supplier_bob.reload
          }.to change(supplier_bob, :name).to("Frank Zappa")
        end
      end

      context "with invalid params" do
        before do
          put :update, id: supplier_bob, supplier: attributes_for(:invalid_supplier)
        end
        it { should render_template :edit }
      end
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: supplier_bob }
      it { should assign_to(:supplier).with supplier_bob }
      it { should redirect_to suppliers_path }
      it { should_not set_the_flash }
    end
  end

  describe "user not signed in" do
    describe "GET #index" do
      before { get :index }
      it_behaves_like "has no rights"
    end

    describe "GET #new" do
      before { get :new }
      it_behaves_like "has no rights"
    end

    describe "POST #create" do
      before { post :create, supplier: attributes_for(:supplier) }
      it_behaves_like "has no rights"
    end

    describe "GET #edit" do
      before { get :edit, id: supplier_bob.id }
      it_behaves_like "has no rights"
    end

    describe "PUT #update" do
      before { put :update, id: supplier_bob, supplier: attributes_for(:supplier) }
      it_behaves_like "has no rights"
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: supplier_bob.id }
      it_behaves_like "has no rights"
      it "not deletes supplier" do
        expect {
          delete :destroy, id: supplier_smith.id
        }.to_not change(Supplier, :count).to(-1)
      end
    end

    describe "GET #tasks" do
      before { get :tasks, id: supplier_bob.id }
      it_behaves_like "has no rights"
    end

    describe "GET #info" do
      before { get :info, id: supplier_bob.id }
      it_behaves_like "has no rights"
    end
  end
end
