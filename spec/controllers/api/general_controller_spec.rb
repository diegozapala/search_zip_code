require 'rails_helper'

RSpec.describe Api::GeneralController do
  describe "GET /index" do
    it "renders successfully" do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
