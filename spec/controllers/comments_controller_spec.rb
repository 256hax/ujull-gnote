require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Message. As you add validations to Message, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {{
    :body => Faker::Lorem.sentence,
    :message_id => 1,
    :user_id => 1
  }}

  let(:invalid_attributes) {{
    :body => '', # empty body
    :user_id => 0 # not exist user
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MessagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #new" do
    context "when user is not logged in" do
      it "redirect to login page" do
        get :new, params: { message_id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user logged in" do
      # behavior: run before(:each)
      # source: spec/support/controller_macros.rb
      login_user

      before do
        @message = FactoryBot.create(:message)
      end

      it "should have a current_user" do
        # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
        expect(subject.current_user).to_not eq(nil)
      end

      it "response successfully" do
        get :new, params: { message_id: 1 }
        expect(response).to be_successful
      end
    end
  end

  describe "POST #create" do
    login_user

    before do
      @users_summary = FactoryBot.create(:users_summary)
      @message = FactoryBot.create(:message)
    end

    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create,
          params: { message_id: 1, comment: valid_attributes },
          session: valid_session
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the root" do
        post :create, params: { message_id: 1, comment: valid_attributes }, session: valid_session
        expect(response).to redirect_to(root_path)
      end

      it "increase User Summary counter" do
        post :create, params: { message_id: 1, comment: valid_attributes }, session: valid_session
        expect { @users_summary.reload }.to change { @users_summary.comments_count }.by(1)
      end
    end

    context "with invalid params" do
      it "has not saved" do
        expect {
          post :create,
          params: { message_id: 1, comment: invalid_attributes },
          session: valid_session
        }.to change(Comment, :count).by(0)
      end
    end

    context "when user is not logged in" do
      # behavior: run before(:each)
      # source: spec/support/controller_macros.rb
      logout_user

      it "redirect to login page" do
        post :create, params: { message_id: 1, comment: valid_attributes }, session: valid_session
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    login_user

    before do
      @users_summary = FactoryBot.create(:users_summary)
      @message = FactoryBot.create(:message) # create Message before create Comment for Associations.
      @message = FactoryBot.create(:comment)
    end

    context "with valid params" do
      it "delete a Cooment" do
        expect {
          delete :destroy,
          params: { id: 1 },
          session: valid_session
        }.to change(Comment, :count).by(-1)
      end

      it "redirects to the root" do
        delete :destroy, params: { id: 1 }, session: valid_session
        expect(response).to redirect_to(root_path)
      end

      it "decrease User Summary counter" do
        delete :destroy, params: { id: 1 }, session: valid_session
        expect { @users_summary.reload }.to change { @users_summary.comments_count}.by(-1)
      end
    end

    context "with invalid params" do
      it "has not deleted (try delete to non-existent comment id)" do
        expect {
          delete :destroy,
          params: { id: 0 },
          session: valid_session
        }.to change(Comment, :count).by(0)
      end
    end

    context "when user is not logged in" do
      # behavior: run before(:each)
      # source: spec/support/controller_macros.rb
      logout_user

      it "redirect to login page" do
        delete :destroy, params: { id: 1 }, session: valid_session
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when another user logged in" do
      logout_user
      login_another_user

      it "redirect to root page" do
        delete :destroy, params: { id: 1 }, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
