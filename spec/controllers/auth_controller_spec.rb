require "rails_helper"

RSpec.describe AuthController do
  describe "Post /login" do

    it "with the correct parameters" do
      create_user

      get_header('joao.silva@teste.com', '123456')
      post :login

      expect(response.status).to eq(200)
    end

    it "with the wrong email" do
      create_user

      get_header('joao.santos@teste.com', '123456')
      post :login

      expect(response.status).to eq(401)
    end

    it "with the wrong password" do
      create_user

      get_header('joao.silva@teste.com', '654321')
      post :login

      expect(response.status).to eq(401)
    end

  end

  def create_user
    user = User.create(name: 'João', last_name: 'Silva', email: 'joao.silva@teste.com', password: '123456')
  end

  def get_header(email, password)
    request.headers["Authorization"] = "Basic #{Base64.encode64("#{email}:#{password}")}"
  end

end
