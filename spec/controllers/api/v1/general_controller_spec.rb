require 'rails_helper'

RSpec.describe Api::V1::GeneralController do
  describe "GET /index" do
    it "renders successfully" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET /search" do
    it "with valid auth token" do
      create_address_base
      login

      get :search, params: { zip_code: '03088000' }
      expect(response.status).to eq(200)
    end

    it "with invalid auth token" do
      get :search, params: { zip_code: '03088000' }
      expect(response.status).to eq(401)
    end

    it "with valid zip code" do
      create_address_base
      login

      get :search, params: { zip_code: '03088000' }
      expect(response.status).to eq(200)
    end

    it "with invalid zip code" do
      create_address_base
      login

      get :search, params: { zip_code: '00000000' }
      expect(response.status).to eq(404)
    end
  end

  def create_address_base
    state = State.create(external_id: '0001', uf: 'SP', name: 'São Paulo')
    city = City.create(state: state, external_id: '0001', name: 'São Paulo')
  end

  def login
    user = User.create(name: 'João', last_name: 'Silva', email: 'joao.silva@teste.com', password: '123456')
    token = @controller.instance_eval{ authentication(id: user.id).encode }
    request.headers["Authorization"] = "Bearer #{token}"
  end
end
