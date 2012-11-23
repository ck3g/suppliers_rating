require 'spec_helper'

describe TasksController do
  let!(:ss) { create :supplier_service }
  let!(:task) { create :task, supplier_service: ss }
  let!(:another_task) { create :task }

  describe "user is signed in" do
    login_user
    let(:user) { subject.current_user }
    it_behaves_like "user is signed in"

    describe "GET #index" do
      before { get :index }
      it { should assign_to(:tasks).with [another_task, task] }
      it { should respond_with :success }
      it { should render_template :index }
    end

    describe "GET #new" do
      before { get :new, supplier_service_id: ss.id }
      it { should assign_to(:task).with_kind_of Task }
      it { should respond_with :success }
      it { should render_template :new }
    end

    describe "GET #new_from_scratch" do
      before { get :new_from_scratch }
      it { should assign_to(:task).with_kind_of Task }
      it { should respond_with :success }
      it { should render_template :new_from_scratch }
    end

    describe "POST #create" do
      context "with valid parameters" do
        before { post :create, task: attributes_for(:task), supplier_service_id: ss.id }
        it { should assign_to(:task).with_kind_of Task }
        it { should redirect_to tasks_path }
        it { should set_the_flash[:notice].to I18n.t(:successfully_created) }
        it "creates new task" do
          expect {
            post :create, task: attributes_for(:task), supplier_service_id: ss.id
          }.to change(Task, :count).by(1)
        end

        context "when callback url passed" do
          before { post :create, task: attributes_for(:task), supplier_service_id: ss.id, callback_url: root_path }
          it { should redirect_to root_path }
        end
      end

      context "with invalid parameters" do
        before { post :create, task: attributes_for(:invalid_task), supplier_service_id: ss.id }
        it { should render_template :new }
        it "dont creates new task" do
          expect {
            post :create, task: attributes_for(:invalid_task), supplier_service_id: ss.id
          }.to_not change(Task, :count).by(1)
        end
      end
    end

    describe "POST #create_from_scratch" do
      let!(:supplier) { create :supplier }
      let!(:service) { create :service }
      let!(:another_service) { create :service }

      context "when valid parameters" do
        context "when suppliers_service not exists" do
          before { post :create_from_scratch, task: attributes_for(:task, supplier_id: supplier.id, service_id: service.id) }
          it { should redirect_to root_path }
          it { should set_the_flash[:notice].to I18n.t(:successfully_created) }

          it "creates new supplier_service" do
            expect {
              post :create_from_scratch, task: attributes_for(:task, supplier_id: supplier.id, service_id: another_service.id)
            }.to change(SupplierService, :count).by(1)
          end
        end

        context "when suppliers_service is exists" do

        end
      end

      context 'when invalid parameters' do
        context "when supplier invalid" do
          before { post :create_from_scratch, task: attributes_for(:task, service_id: service.id) }
          it { should render_template :new_from_scratch }
          it { should set_the_flash[:alert].to I18n.t(:invalid_supplier) }
          it { should assign_to(:task).with_kind_of Task }
        end

        context "when service invalid" do
          before { post :create_from_scratch, task: attributes_for(:task, supplier_id: supplier.id) }
          it { should render_template :new_from_scratch }
          it { should set_the_flash[:alert].to I18n.t(:invalid_service) }
          it { should assign_to(:task).with_kind_of Task }
        end
      end
    end

    describe "GET #show" do
      before { get :show, id: task }
      it { should assign_to(:task).with task }
      it { should respond_with :success }
      it { should render_template :show }
    end

    describe "GET #edit" do
      before { get :edit, id: task }
      it { should assign_to(:task).with task }
      it { should respond_with :success }
      it { should render_template :edit }
    end

    describe "PUT #update" do
      context "with valid parameters" do
        before { put :update, id: task, task: attributes_for(:task, title: "New Title") }
        it { should assign_to(:task).with task }
        it { should set_the_flash[:notice].to I18n.t(:successfully_updated) }
        it { should redirect_to tasks_path }

        it "changes task title" do
          expect {
            put :update, id: task, task: attributes_for(:task, supplier_service_id: ss.id, title: "New Title")
            task.reload
          }.to change(task, :title).to("New Title")
        end

        context "when callback url passed" do
          before { put :update, id: task, task: attributes_for(:task, title: "New Title"), callback_url: root_path }
          it { should redirect_to root_path }
        end
      end

      context "with invalid parameters" do
        before { put :update, id: task, task: attributes_for(:task, title: "") }
        it { should render_template :edit }
        it "dont change task title" do
          expect {
            put :update, id: task, task: attributes_for(:task, title: "")
            task.reload
          }.to_not change(task, :title).to("")
        end
      end
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: task }
      it { should assign_to(:task).with task }
      it { should redirect_to tasks_path }
      it { should_not set_the_flash }

      context "when callback_url passed" do
        before { delete :destroy, id: another_task, callback_url: root_path }
        it { should redirect_to root_path }
      end
    end

    describe "POST #reopen" do
      let!(:closed_task1) { create :closed_task }
      let!(:closed_task2) { create :closed_task }
      before { xhr :post, :reopen, id: closed_task1 }
      it { should render_template :reload }
      it { should assign_to(:task).with closed_task1 }
      it "changes the status to open" do
        expect {
          xhr :post, :reopen, id: closed_task2
          closed_task2.reload
        }.to change(closed_task2, :status).to("open")
      end
    end
  end

  describe "user is not signed in" do
    describe "GET #index" do
      before { get :index }
      it_behaves_like "has no rights"
    end

    describe "GET #new" do
      before { get :new }
      it_behaves_like "has no rights"
    end

    describe "GET #new_from_scratch" do
      before { get :new_from_scratch }
      it_behaves_like "has no rights"
    end

    describe "POST #create" do
      before { post :create, task: attributes_for(:task) }
      it_behaves_like "has no rights"
    end

    describe "POST #create_from_scratch" do
      before { post :create_from_scratch, task: attributes_for(:task) }
      it_behaves_like "has no rights"
    end

    describe "GET #show" do
      before { get :show, id: task }
      it_behaves_like "has no rights"
    end

    describe "GET #edit" do
      before { get :edit, id: task }
      it_behaves_like "has no rights"
    end

    describe "PUT #update" do
      before { put :update, id: task, service: attributes_for(:task) }
      it_behaves_like "has no rights"
    end

    describe "POST #reopen" do
      before { post :reopen, id: task }
      it_behaves_like "has no rights"
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: task }
      it_behaves_like "has no rights"
      it "not deletes service" do
        expect {
          delete :destroy, id: task
        }.to_not change(Task, :count).to(-1)
      end
    end
  end
end
