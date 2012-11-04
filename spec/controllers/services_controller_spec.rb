require 'spec_helper'

describe ServicesController do
  let!(:service_webdev) { create :service, name: "WebDev" }
  let!(:service_reading) { create :service, name: "Reading" }

  describe "user signed in" do
    login_user
    let(:user) { subject.current_user }

    it "user is signed in" do
      user.should_not be_nil
    end

    describe "GET #index" do
      before { get :index }
      it { should assign_to(:services).with [service_reading, service_webdev] }
      it { should respond_with :success }
      it { should render_template :index }
      it { should_not set_the_flash }
    end

    describe "GET #new" do
      before { get :new }
      it { should assign_to(:service).with_kind_of Service }
      it { should respond_with :success }
      it { should render_template :new }
      it { should_not set_the_flash }
    end

    describe "POST #create" do
      context "with valid params" do
        before do
          post :create, service: attributes_for(:service)
        end
        it { should assign_to(:service).with_kind_of Service }
        it { should redirect_to services_path }
        it { should set_the_flash[:notice].to I18n.t(:successfully_created) }
        it "creates new service" do
          expect {
            post :create, service: attributes_for(:service)
          }.to change(Service, :count).by(1)
        end
      end

      context "with invalid params" do
        before do
          post :create, service: attributes_for(:invalid_service)
        end
        it { should render_template :new }
        it "not creates new service" do
          expect {
            post :create, service: attributes_for(:invalid_service)
          }.to_not change(Service, :count).by(1)
        end
      end
    end

    describe "GET #edit" do
      before { get :edit, id: service_webdev }
      it { should assign_to(:service).with service_webdev }
      it { should respond_with :success }
      it { should render_template :edit }
      it { should_not set_the_flash }
    end

    describe "PUT #update" do
      context "with valid params" do
        before do
          put :update, id: service_webdev, service: attributes_for(:service)
        end
        it { should assign_to(:service).with service_webdev }
        it { should redirect_to services_path }
        it { should set_the_flash[:notice].to I18n.t(:successfully_updated) }
        it "changes service's attributes" do
          expect {
            put :update, id: service_webdev, service: attributes_for(:service, name: "Drinking Beer")
            service_webdev.reload
          }.to change(service_webdev, :name).to("Drinking Beer")
        end
      end

      context "with invalid params" do
        before do
          put :update, id: service_webdev, service: attributes_for(:invalid_service)
        end
        it { should render_template :edit}
      end
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: service_webdev }
      it { should assign_to(:service).with service_webdev }
      it { should redirect_to services_path }
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
      before { post :create, service: attributes_for(:service) }
      it_behaves_like "has no rights"
    end

    describe "GET #edit" do
      before { get :edit, id: service_webdev }
      it_behaves_like "has no rights"
    end

    describe "PUT #update" do
      before { put :update, id: service_webdev, service: attributes_for(:service) }
      it_behaves_like "has no rights"
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: service_webdev.id }
      it_behaves_like "has no rights"
      it "not deletes service" do
        expect {
          delete :destroy, id: service_webdev.id
        }.to_not change(Service, :count).to(-1)
      end
    end
  end
end
