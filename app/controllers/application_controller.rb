class ApplicationController < ActionController::API

  before_action :request_auth

  def request_auth
    unless current_user.present?
      render json: default_error_json(message: message_401), status: :unauthorized
    end
  end

  def current_user
    @current_user ||= authentication(token: auth_param(request)).user
  end

  def default_json(message: message_200, data: [])
    {status: 'SUCCESS', message: message, data: data}
  end

  def default_error_json(message: 'Houve um erro com sua solicitação')
    {status: 'ERROR', message: message}
  end

  def message_200
    'solicitação efetuada com sucesso'
  end

  def message_401
    'Acesso não autorizado'
  end

  def message_404
    'CEP não encontrado'
  end

  def message_500
    'Erro interno no servidor'
  end

  def message_200_login
    'Login efetuado com sucesso'
  end

  def message_401_login
    'E-mail ou senha inválida'
  end

  private

    def authentication(id: nil, token: nil)
      AuthenticateUser.new(id: id, token: token)
    end

    def auth_param(request)
      request.authorization.to_s.split(' ', 2).second
    end

end
