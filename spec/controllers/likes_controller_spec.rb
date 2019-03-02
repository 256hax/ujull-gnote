require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  let(:valid_attributes) {{
    :message_id => 1
  }}

  let(:invalid_attributes) {{
    :message_id => 0 # not exist message
  }}

  let(:valid_session) { {} }

  describe "POST #create" do
    login_user

    before do
      @users_summary = FactoryBot.create(:users_summary)
      @message = FactoryBot.create(:message)
    end

    context "with valid params" do
      it "creates a new Like" do
        # This code can't get response. => "expected `Like.count` to have changed by 1, but was changed by 0". Use "expect{}" code instead below.
        # --- Error Code ---
        # post :create, xhr: true, params: valid_attributes
        # expect{response}.to change(Like, :count).by(1)
        # ------------------
        expect {
          post :create,
          xhr: true,
          params: valid_attributes,
          session: valid_session
        }.to change(Like, :count).by(1)
      end

      it "increase Message Likes counter" do
        post :create, xhr: true, params: valid_attributes, session: valid_session
        expect { @message.reload }.to change { @message.likes_count }.by(1)
      end

      it "increase User Summary counter" do
        post :create, xhr: true, params: valid_attributes, session: valid_session
        expect { @users_summary.reload }.to change { @users_summary.likes_count }.by(1)
      end
    end

    context "with invalid params" do
      it "returns error" do
        expect {
          post :create,
          xhr: true,
          params: invalid_attributes,
          session: valid_session
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when user is not logged in" do
      # behavior: run before(:each)
      # source: spec/support/controller_macros.rb
      logout_user

      it "returns 401" do
        # 401 error display a page so, It can get response.
        post :create, xhr: true, params: valid_attributes
        expect(response).to have_http_status(401)
      end
    end
  end
end
