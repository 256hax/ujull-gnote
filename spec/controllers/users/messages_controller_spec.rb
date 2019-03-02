require 'rails_helper'

RSpec.describe Users::MessagesController, type: :controller do
  # [Test Patterns]
  # Case1. User logged in         => Show only my contents (user_id: 1)
  # Case2. Not logged in          => Not show any contents
  # Case3. Another User logged in => Not show User(user_id: 1) contents
  describe "GET #index" do
    context "when user logged in" do
      login_user

      before do
        FactoryBot.create(:message)
      end

      it "show my contents" do
        get :index
        expect( assigns(:messages)[0].user_id ).to eq(1)
      end
    end

    context "when user is not logged in" do
      logout_user

      it "redirect to login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when another user logged in" do
      login_another_user

      before do
        FactoryBot.create(:another_user_message)
      end

      it "not show User(user_id: 1) contents" do
        get :index
        expect( assigns(:messages)[0].user_id ).not_to eq(1)
      end
    end
  end
end
