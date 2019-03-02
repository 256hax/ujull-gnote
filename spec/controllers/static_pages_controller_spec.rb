require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "GET #about" do
    it "response successfully" do
      get :about
      expect(response).to be_successful
    end
  end

  describe "GET #howto" do
    it "response successfully" do
      get :howto
      expect(response).to be_successful
    end
  end
end
