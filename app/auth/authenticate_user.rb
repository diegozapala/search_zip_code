class AuthenticateUser

  HMAC_SECRET = ENV['AUTH_SECRET_KEY']

  attr_reader :id, :token

  def initialize(id: nil, token: nil)
    @id = id
    @token = token
  end

  def encode
    return unless id.present?

    payload = { id: id, exp: 1.week.from_now.to_i, iat: Time.now.to_i }
    token = JWT.encode payload, HMAC_SECRET, 'HS256', typ: 'JWT'
  end

  def decode
    return unless token.present?
    decoded_token = JWT.decode token, HMAC_SECRET, true, { algorithm: 'HS256' }
  end

  def user
    return unless find_decode
    User.active.find_by(id: find_decode['id'])
  end


  private

  def find_decode
    find_decode ||= decode ? decode.first : nil
  end

end
