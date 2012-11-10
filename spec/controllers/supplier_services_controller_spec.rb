require 'spec_helper'

describe SupplierServicesController do
  let!(:webdev) { create :supplier_service }
  let!(:design) { create :supplier_service }

  describe "user signed in" do
    login_user
    let(:user) { subject.current_user }
    it_behaves_like "user is signed in"

    describe "GET #new" do
      before { get :new }
      it { should assign_to(:supplier_service).with_kind_of SupplierService }
      it { should respond_with :success }
      it { should render_template :new }
      it { should_not set_the_flash }
    end

    describe "POST #create" do
      context "with valid params" do
        before do
          @attrs = attributes_for(:supplier_service, supplier_id: create(:supplier).id, service_id: create(:service).id)
          post :create, supplier_service: @attrs
        end
        it { should assign_to(:supplier_service).with_kind_of SupplierService }
        it { should redirect_to suppliers_path }
        it { should set_the_flash[:notice].to I18n.t(:successfully_created) }

        it "creates new supplier service" do
          expect {
            post :create, supplier_service: @attrs
          }.to change(SupplierService, :count).by(1)
        end

        context "when callback url is passed" do
          before do
            post :create, supplier_service: @attrs, callback_url: services_path
          end
          it { should redirect_to services_path }
        end
      end

      context "with invalid params" do
        before do
          post :create, supplier_service: attributes_for(:invalid_supplier_service)
        end
        it { should render_template :new }
        it "not creates new supplier" do
          expect {
            post :create, supplier: attributes_for(:invalid_supplier_service)
          }.to_not change(SupplierService, :count).by(1)
        end
      end
    end

    describe "GET #edit" do
      before { get :edit, id: webdev }
      it { should assign_to(:supplier_service).with webdev }
      it { should respond_with :success }
      it { should render_template :edit }
    end

    describe "PUT #update" do
      context "when valid params" do
        before do
          @attrs = attributes_for(:supplier_service, supplier_id: create(:supplier).id, service_id: create(:service).id, price: 5.5)
          put :update, id: webdev, supplier_service: @attrs
        end
        it { should assign_to(:supplier_service).with webdev }
        it { should redirect_to suppliers_path }
        it { should set_the_flash[:notice].to I18n.t(:successfully_updated) }
        it "changes supplier service price" do
          expect {
            put :update, id: webdev, supplier_service: @attrs
            webdev.reload
          }.to change(webdev, :price).to(5.5)
        end

        context "when callback_url passed" do
          before do
            put :update, id: webdev, supplier_service: @attrs, callback_url: services_path
          end
          it { should redirect_to services_path }
        end
      end

      context "when invalid params" do
        before do
          put :update, id: webdev, supplier_service: attributes_for(:invalid_supplier_service)
        end
        it { should render_template :edit }
      end
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: webdev }
      it { should assign_to(:supplier_service).with webdev }
      it { should_not set_the_flash }
      it { should redirect_to suppliers_path }

      context "when callback url passed" do
        before { delete :destroy, id: design, callback_url: supplier_path(design.supplier) }
        it { should redirect_to supplier_path(design.supplier) }
      end
    end
  end

  describe "user not signed on" do
    describe "GET #new" do
      before { get :new }
      it_behaves_like "has no rights"
    end

    describe "POST #create" do
      before { post :create, supplier_service: attributes_for(:supplier_service) }
      it_behaves_like "has no rights"
    end

    describe "GET #edit" do
      before { get :edit, id: webdev }
      it_behaves_like "has no rights"
    end

    describe "PUT #update" do
      before { put :update, id: webdev, supplier_service: attributes_for(:supplier_service) }
      it_behaves_like "has no rights"
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: webdev }
      it_behaves_like "has no rights"
      it "not deletes supplier service" do
        expect {
          delete :destroy, id: webdev
        }.to_not change(SupplierService, :count).to(-1)
      end
    end
  end
end
