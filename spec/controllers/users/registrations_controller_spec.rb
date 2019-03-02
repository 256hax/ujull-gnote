require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do

  let(:valid_attributes) {{
    :email => Faker::Internet.email,
    :password => "password",
    :password_confirmation => "password",
    :confirmed_at => Time.now
  }}

  describe "POST #create" do
    include DataInitializable

    login_user
    logout_user

    context "with valid params" do
      it "creates a new User and Users::Summary" do
        fix_sequence_id(:users) # concerns/data_initializable.rb

        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        .and change(Users::Summary, :count).by(1)
      end
    end
  end
end
