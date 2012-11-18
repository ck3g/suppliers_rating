require 'spec_helper'

describe CommentsController do
  let(:task) { create :task }
  let!(:comment) { create :comment, commentable: task }
  let!(:another_comment) { create :comment, commentable: task }

  describe "user is signed in" do
    login_user
    let(:user) { subject.current_user }
    it_behaves_like "user is signed in"

    describe "POST #create" do
      context "with valid parameters" do
        before { xhr :post, :create, comment: attributes_for(:comment), task_id: task.id }
        it { should assign_to(:comment).with_kind_of Comment }
        it { should assign_to(:task).with task }
        it { should render_template 'tasks/reload' }

        it "creates new comment" do
          expect {
            xhr :post, :create, comment: attributes_for(:comment), task_id: task.id
          }.to change(Comment, :count).by(1)
        end

        context "when closes task" do
          it "closes the task" do
            expect {
              xhr :post, :create, comment: attributes_for(:comment), task_id: task.id, close: 1, task_rating: 5
              task.reload
            }.to change(task, :status).to("closed")
          end
        end
      end

      context "with invalid parameters" do

      end
    end

    describe "DELETE #destroy" do
      before { xhr :delete, :destroy, id: comment, task_id: task }
      it { should assign_to(:comment).with_kind_of Comment }
      it { should render_template "tasks/reload" }
      it { should_not set_the_flash }
      it { should assign_to(:comments).with [another_comment] }
    end
  end

  describe "user is not signed in" do
    describe "POST #create" do
      before { post :create, comment: attributes_for(:comment), task_id: task }
      it_behaves_like "has no rights"
    end

    describe "DELETE #destroy" do
      before { delete :destroy, task_id: task, id: comment }
      it_behaves_like "has no rights"
      it "not deletes service" do
        expect {
          delete :destroy, task_id: task, id: comment
        }.to_not change(Comment, :count).to(-1)
      end
    end
  end
end
