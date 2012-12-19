require 'spec_helper'

describe CategoriesController do
  let!(:webdev) { create :category, name: "WebDev" }
  let!(:design) { create :category, name: "Design" }

  describe "user signed in" do
    login_user
    let(:user) { subject.current_user }
    it_behaves_like "user is signed in"

    describe "GET #index" do
      before { get :index }
      it { should assign_to(:categories).with [design, webdev] }
      it { should respond_with :success }
      it { should render_template :index }
      it { should_not set_the_flash }
    end

    describe "GET #new" do
      before { get :new }
      it { should assign_to(:category).with_kind_of Category }
      it { should respond_with :success }
      it { should render_template :new }
      it { should_not set_the_flash }
    end

    describe "POST #create" do
      context "with valid params" do
        before do
          post :create, category: attributes_for(:category)
        end
        it { should assign_to(:category).with_kind_of Category }
        it { should redirect_to categories_path }
        it { should set_the_flash[:notice].to I18n.t(:successfully_created) }
        it "creates new category" do
          expect {
            post :create, category: attributes_for(:category)
          }.to change(Category, :count).by(1)
        end
      end

      context "with invalid params" do
        before do
          post :create, service: attributes_for(:invalid_category)
        end
        it { should render_template :new }
        it "not creates new category" do
          expect {
            post :create, service: attributes_for(:invalid_category)
          }.to_not change(Category, :count).by(1)
        end
      end
    end

    describe "GET #edit" do
      before { get :edit, id: webdev }
      it { should assign_to(:category).with webdev }
      it { should respond_with :success }
      it { should render_template :edit }
      it { should_not set_the_flash }
    end

    describe "PUT #update" do
      context "with valid params" do
        before do
          put :update, id: webdev, category: attributes_for(:category)
        end
        it { should assign_to(:category).with webdev }
        it { should redirect_to categories_path }
        it { should set_the_flash[:notice].to I18n.t(:successfully_updated) }
      end

      context "with invalid params" do
        before do
          put :update, id: webdev, category: attributes_for(:invalid_category)
        end
        it { should render_template :edit }
      end
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: webdev }
      it { should assign_to(:category).with webdev }
      it { should redirect_to categories_path }
      it { should_not set_the_flash }
      it "deletes the category" do
        expect {
          delete :destroy, id: design
        }.to change(Category, :count).by(-1)
      end
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
      before { post :create, service: attributes_for(:category) }
      it_behaves_like "has no rights"
    end

    describe "GET #edit" do
      before { get :edit, id: webdev }
      it_behaves_like "has no rights"
    end

    describe "PUT #update" do
      before { put :update, id: webdev, category: attributes_for(:category) }
      it_behaves_like "has no rights"
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: webdev.id }
      it_behaves_like "has no rights"
      it "not deletes category" do
        expect {
          delete :destroy, id: webdev.id
        }.to_not change(Category, :count).to(-1)
      end
    end
  end
end
