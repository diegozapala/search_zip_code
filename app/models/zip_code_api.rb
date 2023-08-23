class ZipCodeApi
  require "net/http"

  API_URL = 'http://cep.la/'

  def self.get_address(zip_code:)
    return [] unless zip_code.length == 8

    uri = URI("#{API_URL}#{zip_code}")

    req = Net::HTTP::Get.new(uri)
    req['Accept'] = 'application/json'

    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }

    JSON.parse(res.body)
  end
end
