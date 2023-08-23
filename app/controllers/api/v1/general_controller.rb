class Api::V1::GeneralController < ApplicationController

  skip_before_action :request_auth, only: [:index]

  def index
    render json: default_json, status: :ok
  end

  def search
    if find_address.present?
      UserAddress.find_or_create_by(user: current_user, address: find_address)
      return render json: default_json(message: message_200, data: build_data), status: :ok
    else
      return render json: default_error_json(message: message_404), status: :not_found
    end
  end

  private

    def zip_code_params
      params.permit(:zip_code)
    end

    def zip_code
      zip_code ||= zip_code_params[:zip_code].delete(' ').delete('.').delete('-')
    end

    def find_address
      @find_address ||= Address.find_by(zip_code: zip_code) || build_address
    end

    def build_address
      address_data = ZipCodeApi.get_address(zip_code: zip_code)

      return unless address_data.present?

      Address.create(state: State.find_by(uf: address_data["uf"]),
                     city:  City.find_by(name: address_data["cidade"]),
                     neighborhood: address_data["bairro"],
                     street: address_data["logradouro"],
                     zip_code: address_data["cep"])
    end

    def build_data
      {
        state: find_address.state.uf,
        city: find_address.city.name,
        neighborhood: find_address.neighborhood,
        address: find_address.street,
        zip_code: find_address.zip_code,
        full_address: find_address.full_address
      }
    end
end
