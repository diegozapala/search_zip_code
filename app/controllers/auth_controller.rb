class AuthController < ApplicationController

  skip_before_action :request_auth, only: [:login]

  def login
    if find_user && find_user.authenticate(user_password)
      return render json: default_json(message: message_200_login, data: build_data), status: :ok
    else
      return render json: default_error_json(message: message_401_login), status: :unauthorized
    end
  end

  private

    def decode_credentials(request)
      ::Base64.decode64(auth_param(request) || '').split(":", 2)
    end

    def user_email
      decode_credentials(request).first || ''
    end

    def user_password
      decode_credentials(request).second || ''
    end

    def find_user
      @user ||= User.active.find_by(email: user_email.downcase.delete(' '))
    end

    def encode_user
      @encode_user ||= authentication(id: find_user.id).encode
    end

    def build_data
      {
        token: encode_user,
        user: {
          name: find_user.name,
          last_name: find_user.last_name,
          email: find_user.email
        }
      }
    end

end
