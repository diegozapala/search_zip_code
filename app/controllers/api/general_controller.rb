class Api::GeneralController < ApplicationController

  skip_before_action :request_auth, only: [:index]

  def index
    render json: default_json, status: :ok
  end

end
