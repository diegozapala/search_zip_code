require "rails_helper"

RSpec.describe ApplicationController do
  it "current_user with token" do
    user = create_user
    token = login(user)

    request.headers["Authorization"] = "Bearer #{token}"
    response = @controller.instance_eval{ current_user }

    expect(response).to eq(user)
  end

  it "current_user without token" do
    response = @controller.instance_eval{ current_user }
    expect(response).to eq(nil)
  end

  def create_user
    User.create(name: 'João', last_name: 'Silva', email: 'joao.silva@teste.com', password: '123456')
  end

  def login(user)
    @controller.instance_eval{ authentication(id: user.id).encode }
  end

end
